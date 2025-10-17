import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import '../../utils/constants/apis.dart';

class StripeServices extends GetxController{
  static StripeServices get instance => Get.find();


  /// Variables
  final _dio = dio.Dio();



  /// Function to create payment intents
  Future<dynamic> createPaymentIntents(String currency, int amount) async {
    try {
      String url = UApiUrls.stripeCreateIntents;

      final data = {
        'currency': currency,
        'amount': amount,
        'payment_method_types[]': 'card'
      };

      dio.Response response = await _dio.post(url, data: data, options: dio.Options(
          headers: {
            'Authorization': 'Bearer ${UKeys.stripeSecretKey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          }
      ));

      if (response.statusCode == 200) {
        return response.data;
      }
    }catch(e){
      throw 'Something went wrong while creating payment intents';
    }
  }

  /// Function to initialize the payment sheet
  Future<void> initPaymentSheet(String currency, int amount) async {
    try {
      // 1. create payment intent on the server
      final data = await createPaymentIntents(currency, amount);

      log(data.toString());

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: true,
          // Main params
          merchantDisplayName: 'Shopping App',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerId: data['id'],
          // Extra options
          // applePay: const PaymentSheetApplePay(
          //   merchantCountryCode: 'US',
          // ),
          googlePay: const PaymentSheetGooglePay(
            buttonType: PlatformButtonType.buy,
            merchantCountryCode: 'US',
            testEnv: true,
          ),
          style: ThemeMode.dark,
        ),
      );

    } catch (e) {
      throw 'Something went wrong while initializing the payment sheet';
    }
  }

  /// Function to show the stripe payment sheet
  Future<void> showPaymentSheet() async{
    try{

      await Stripe.instance.presentPaymentSheet();

    } on StripeException catch(e){
      switch(e.error.code){
        case FailureCode.Canceled:
          throw 'Payment Canceled';
        case FailureCode.Failed:
          throw 'Payment Failed';
        case FailureCode.Timeout:
          throw 'Payment Timeout';
        case FailureCode.Unknown:
          throw 'An unknown error occurred';
      }
    }
    catch(e){
      throw 'Something went wrong while showing the payment sheet';
    }

  }
}