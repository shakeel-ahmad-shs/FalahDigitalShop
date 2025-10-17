
import 'package:e_commerce/features/shop/controllers/product/variation_controller.dart';
import 'package:get/get.dart';

import '../features/personalization/controllers/address_controller.dart';
import '../utils/helpers/network_manager.dart';

class UBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    //Get.put(CheckoutController());
    Get.put(AddressController());


  }

}