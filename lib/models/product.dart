import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String _id;
  String _name;
  String _restaurantId;
  String _restaurant;
  String _category;
  String _image;
  String _description;
  double _rating;
  double _price;
  List<int> _rates;

  String get id => _id;
  String get name => _name;
  String get restaurant => _restaurant;
  String get restaurantId => _restaurantId;
  String get category => _category;
  String get description => _description;
  String get image => _image;
  double get rating => _rating;
  double get price => _price;
  List<int> get rates => _rates;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    _id = data['id'];
    _image = data['image'];
    _restaurant = data['restaurant'];
    _restaurantId = data['restaurantId'];
    _category = data['category'];
    _description = data['description'];
    _price = double.parse(data['price'].toString());
    _rating = double.parse(data['rating'].toString());
    _name = data['name'];
    _rates = _getList(data['rates']);
  }

  List<int> _getList(List rates) {
    List<int> tmp = [];
    rates?.forEach((element) {
      tmp.add(element);
    });
    return tmp;
  }
}
