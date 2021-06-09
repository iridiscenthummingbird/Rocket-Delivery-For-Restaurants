import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String _id;
  String _name;
  String _image;

  String get id => _id;
  String get name => _name;
  String get image => _image;

  CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    _id = data['id'];
    _name = data['name'];
    _image = data['image'];
  }
}
