import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rocket_delivery_rest/models/restaurant.dart';

class RestaurantServices {
  String collection = "restaurants";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<RestaurantModel> getRestaurantById({String id}) =>
      _firestore.collection(collection).doc(id.toString()).get().then((doc) {
        return RestaurantModel.fromSnapshot(doc);
      });
}
