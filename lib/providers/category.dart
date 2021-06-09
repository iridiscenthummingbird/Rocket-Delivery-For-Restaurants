import 'package:flutter/material.dart';
import 'package:rocket_delivery_rest/models/category.dart';
import 'package:rocket_delivery_rest/services/category.dart';

class CategoryProvider with ChangeNotifier {
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];
  List<String> categoriesNames = [];
  String selectedCategory;

  CategoryProvider.initialize() {
    loadCategories();
  }

  loadCategories() async {
    categories = await _categoryServices.getCategories();
    for (CategoryModel category in categories) {
      categoriesNames.add(category.name);
    }
    selectedCategory = categoriesNames[0];
    notifyListeners();
  }

  changeSelectedCategory({String newCategory}) {
    selectedCategory = newCategory;
    notifyListeners();
  }
}
