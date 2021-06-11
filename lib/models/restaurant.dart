import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  String _id;
  String _name;
  String _image;
  double _rating;
  double _avgPrice;
  List<int> _rates;

  String get id => _id;
  String get name => _name;
  String get image => _image;
  double get avgPrice => _avgPrice;
  double get rating => _rating;
  List<int> get rates => _rates;

  RestaurantModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    _id = data['id'];
    _name = data['name'];
    _image = data['image'];
    _avgPrice = double.parse(data['avgPrice']);
    _rating = double.parse(data['rating']);
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
