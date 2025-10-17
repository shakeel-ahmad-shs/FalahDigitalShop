import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/repositories/authentication_repository.dart';
import 'package:e_commerce/features/shop/models/order_model.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController{
  static OrderRepository get instance => Get.find();
  
  /// Variables
  final _db = FirebaseFirestore.instance;
  

  /// [Save] - Save user Order
  Future<void> saveOrder(OrderModel order) async{
    try{
      await _db.collection(UKeys.userCollection).doc(order.userId).collection(UKeys.ordersCollection).add(order.toJson());
    }catch(e){
      throw 'Something went wrong while saving order info';
    }
  }

  /// [Fetch] - Fetch user orders
  Future<List<OrderModel>> fetchUserOrders() async{
    try{
      final userId = AuthenticationRepository.instance.currentUser!.uid;
      if(userId.isEmpty) throw 'Unable to find user information';

      final query = await _db.collection(UKeys.userCollection).doc(userId).collection(UKeys.ordersCollection).get();
      if(query.docs.isNotEmpty){
        List<OrderModel> orders = query.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
        return orders;
      }

      return [];

    }catch(e){
      throw 'Something went wrong while order info';
    }
  }
}