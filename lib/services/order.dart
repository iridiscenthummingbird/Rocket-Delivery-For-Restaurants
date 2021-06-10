import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rocket_delivery_rest/models/order.dart';

class OrderServices {
  String collection = "orders";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<OrderModel>> restaurantOrders({String restaurantId}) async =>
      _firestore
          .collection(collection)
          .where("restaurantIDs", arrayContains: restaurantId)
          .get()
          .then((result) {
        List<OrderModel> orders = [];
        result.docs.forEach((element) {
          orders.add(OrderModel.fromSnapshot(element));
        });

        return orders;
      });
}
