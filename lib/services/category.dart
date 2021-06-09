import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rocket_delivery_rest/models/category.dart';

class CategoryServices {
  String collection = "categories";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async =>
      _firestore.collection(collection).get().then((result) {
        List<CategoryModel> categories = [];
        result.docs.forEach((doc) {
          categories.add(CategoryModel.fromSnapshot(doc));
        });
        return categories;
      });
}
