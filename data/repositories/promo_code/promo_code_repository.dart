import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/features/shop/models/promo_code_model.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class PromoCodeRepository extends GetxController{
  static PromoCodeRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;


  /// [Upload] - Function to upload list of promo codes to Firebase
  Future<void> uploadPromoCodes(List<PromoCodeModel> promoCodes) async{
    try{

      for(final promoCode in promoCodes){
        await _db.collection(UKeys.promoCodesCollection).doc(promoCode.id).set(promoCode.toJson());
      }


    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Fetch] - Function to fetch single promo code details
  Future<PromoCodeModel> fetchSinglePromoCode(String code) async{
    try{
      
      final query = await _db.collection(UKeys.promoCodesCollection).where('code', isEqualTo: code).get();
      if(query.docs.isNotEmpty){
        PromoCodeModel promoCode = PromoCodeModel.fromSnapshot(query.docs.first);
        return promoCode;
      }

      return PromoCodeModel.empty();

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Update] - Function to update single field of promo codes
  Future<void> updateSingleField(PromoCodeModel promoCode, String key, dynamic value) async{
    try{

      await _db.collection(UKeys.promoCodesCollection).doc(promoCode.id).update({key : value});

    }on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}