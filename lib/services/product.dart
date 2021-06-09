import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rocket_delivery_rest/models/product.dart';

class ProductServices {
  String collection = "products";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future createProduct({Map data}) async {
    _firestore.collection(collection).doc(data['id']).set({
      "id": data['id'],
      "name": data['name'],
      "image": data['image'],
      "rating": data['rating'],
      "price": data['price'],
      "restaurant": data['restaurant'],
      "restaurantId": data['restaurantId'],
      "description": data['description'],
      "category": data['category']
    });
  }

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).get().then((result) {
        List<ProductModel> products = [];
        result.docs.forEach((doc) {
          products.add(ProductModel.fromSnapshot(doc));
        });
        products.sort((a, b) => b.rating.compareTo(a.rating));
        return products;
      });

  Future<List<ProductModel>> getProductsByRestaurant({String id}) async =>
      _firestore
          .collection(collection)
          .where("restaurantId", isEqualTo: id)
          .get()
          .then((result) {
        List<ProductModel> products = [];
        result.docs.forEach((doc) {
          products.add(ProductModel.fromSnapshot(doc));
        });
        return products;
      });
}
