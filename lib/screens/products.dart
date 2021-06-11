import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery_rest/providers/user.dart';
import 'package:rocket_delivery_rest/screens/add_product.dart';
import 'package:rocket_delivery_rest/services/screen_navigation.dart';
import 'package:rocket_delivery_rest/widgets/product.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.reload();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          changeScreen(context, AddProductScreen());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        tooltip: 'Add Product',
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Products",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        children: userProvider.products
            .map((item) => GestureDetector(
                  onTap: () {
                    //changeScreen(context, Details(product: item,));
                  },
                  child: ProductWidget(
                    product: item,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
