import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rocket_delivery_rest/models/product.dart';
import 'package:rocket_delivery_rest/services/product.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProductProvider with ChangeNotifier {
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  File productImage;
  final picker = ImagePicker();
  String productImageFileName;

  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future<bool> uploadProduct(
      {String category, String restaurant, String restaurantId}) async {
    try {
      String id = Uuid().v1();
      String imageUrl =
          await _uploadImageFile(imageFile: productImage, imageFileName: id);
      Map data = {
        "id": id,
        "name": name.text.trim(),
        "image": imageUrl,
        "rating": 0.0,
        "price": double.parse(price.text.trim()),
        "restaurant": restaurant,
        "restaurantId": restaurantId,
        "description": description.text.trim(),
        "category": category,
        "rates": []
      };
      _productServices.createProduct(data: data);
      //TODO change avgPrice
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

//  method to load image files
  getImageFile({ImageSource source}) async {
    if (source == ImageSource.camera) {
      if (await Permission.camera.request().isDenied) {
        return;
      }
    }
    final pickedFile =
        await picker.getImage(source: source, maxWidth: 640, maxHeight: 400);
    productImage = File(pickedFile.path);
    productImageFileName =
        productImage.path.substring(productImage.path.indexOf('/') + 1);
    notifyListeners();
  }

//  method to upload the file to firebase
  Future _uploadImageFile({File imageFile, String imageFileName}) async {
    firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.ref().child(imageFileName);
    firebase_storage.UploadTask uploadTask = reference.putFile(imageFile);
    String imageUrl = await uploadTask.then((res) async {
      return res.ref.getDownloadURL();
    });
    //String imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    return imageUrl;
  }

  clear() {
    productImage = null;
    productImageFileName = null;
    name = null;
    description = null;
    price = null;
  }
}
