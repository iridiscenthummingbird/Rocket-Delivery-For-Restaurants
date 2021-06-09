class CartItemModel {
  String _id;
  String _name;
  String _image;
  String _productId;
  String _restaurantId;
  int _quantity;
  double _price;

  String get id => _id;
  String get name => _name;
  String get image => _image;
  String get productId => _productId;
  String get restaurantId => _restaurantId;
  double get price => _price;
  int get quantity => _quantity;

  CartItemModel.fromMap(Map data) {
    _id = data["id"];
    _name = data["name"];
    _image = data["image"];
    _productId = data["productID"];
    _price = data["price"];
    _quantity = data["quantity"];
    _restaurantId = data["restaurantID"];
  }
}
