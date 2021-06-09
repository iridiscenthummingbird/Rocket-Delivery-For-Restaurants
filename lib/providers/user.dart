import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rocket_delivery_rest/models/order.dart';
import 'package:rocket_delivery_rest/models/product.dart';
import 'package:rocket_delivery_rest/models/restaurant.dart';
import 'package:rocket_delivery_rest/services/order.dart';
import 'package:rocket_delivery_rest/services/product.dart';
import 'package:rocket_delivery_rest/services/restaurant.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  OrderServices _orderServices = OrderServices();
  RestaurantServices _restaurantServices = RestaurantServices();
  ProductServices _productServices = ProductServices();
  User _user;
  RestaurantModel _restaurant;
  double _avgPrice = 0;
  double _restaurantRating = 0;

  List<ProductModel> products = <ProductModel>[];
  final formkey = GlobalKey<FormState>();

  List<OrderModel> orders = [];

  Status get status => _status;
  User get user => _user;
  RestaurantModel get restaurant => _restaurant;
  double get avgPrice => _avgPrice;
  double get restaurantRating => _restaurantRating;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _restaurant = await _restaurantServices.getRestaurantById(id: user.uid);
    }
    notifyListeners();
  }

  Future<void> reload() async {
    _restaurant = await _restaurantServices.getRestaurantById(id: user.uid);
    await loadProductsByRestaurant(restaurantId: user.uid);
    await getOrders();
    await getAvgPrice();
    notifyListeners();
  }

  Future<bool> signIn(BuildContext context) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      //TODO: cut the message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  Future<bool> signUp(BuildContext context) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        _firestore.collection('restaurants').doc(result.user.uid).set({
          'name': name.text,
          'email': email.text,
          'id': result.user.uid,
          "avgPrice": 0.0.toString(),
          "image": "",
          "rating": 0.0.toString(),
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
  }

  getAvgPrice() async {
    if (products.length != 0) {
      double amountSum = 0;
      for (ProductModel product in products) {
        amountSum = product.price;
      }
      _avgPrice = amountSum / products.length;
    }
    notifyListeners();
  }

  getOrders() async {
    orders = await _orderServices.restaurantOrders(restaurantId: _user.uid);
    notifyListeners();
  }

  Future loadProductsByRestaurant({String restaurantId}) async {
    products = await _productServices.getProductsByRestaurant(id: restaurantId);
    notifyListeners();
  }
}
