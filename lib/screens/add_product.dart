import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery_rest/providers/category.dart';
import 'package:rocket_delivery_rest/providers/product.dart';
import 'package:rocket_delivery_rest/providers/user.dart';
import 'package:rocket_delivery_rest/widgets/custom_file_button.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: key,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Add Product",
            style: TextStyle(color: Colors.black),
          )),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: productProvider?.productImage == null
                      ? CustomFileUploadButton(
                          icon: Icons.image,
                          text: "Add image",
                          onTap: () async {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext bc) {
                                  return Container(
                                    child: new Wrap(
                                      children: <Widget>[
                                        new ListTile(
                                            leading: new Icon(Icons.image),
                                            title: new Text('From gallery'),
                                            onTap: () async {
                                              productProvider.getImageFile(
                                                  source: ImageSource.gallery);
                                              Navigator.pop(context);
                                            }),
                                        new ListTile(
                                            leading: new Icon(Icons.camera_alt),
                                            title: new Text('Take a photo'),
                                            onTap: () async {
                                              productProvider.getImageFile(
                                                  source: ImageSource.camera);
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    ),
                                  );
                                });
                          },
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(productProvider.productImage)),
                ),
              ],
            ),
          ),
          Visibility(
            visible: productProvider.productImage != null,
            child: FlatButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                        child: new Wrap(
                          children: <Widget>[
                            new ListTile(
                                leading: new Icon(Icons.image),
                                title: new Text('From gallery'),
                                onTap: () async {
                                  productProvider.getImageFile(
                                      source: ImageSource.gallery);
                                  Navigator.pop(context);
                                }),
                            new ListTile(
                                leading: new Icon(Icons.camera_alt),
                                title: new Text('Take a photo'),
                                onTap: () async {
                                  productProvider.getImageFile(
                                      source: ImageSource.camera);
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      );
                    });
              },
              child: Text(
                "Change Image",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Category:",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
              ),
              DropdownButton<String>(
                value: categoryProvider.selectedCategory,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w300),
                icon: Icon(
                  Icons.filter_list,
                  color: Colors.red,
                ),
                elevation: 0,
                onChanged: (value) {
                  categoryProvider.changeSelectedCategory(
                      newCategory: value.trim());
                },
                items: categoryProvider.categoriesNames
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(2, 7),
                        blurRadius: 7)
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: TextField(
                  controller: productProvider.name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Product name",
                      hintStyle: TextStyle(
                          color: Colors.grey, fontFamily: "Sen", fontSize: 18)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(2, 7),
                        blurRadius: 7)
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: TextField(
                  controller: productProvider.description,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Product description",
                      hintStyle: TextStyle(
                          color: Colors.grey, fontFamily: "Sen", fontSize: 18)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(2, 7),
                        blurRadius: 7)
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: TextField(
                  controller: productProvider.price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Price",
                      hintStyle: TextStyle(
                          color: Colors.grey, fontFamily: "Sen", fontSize: 18)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(2, 7),
                          blurRadius: 4)
                    ]),
                child: FlatButton(
                  onPressed: () async {
                    if (!await productProvider.uploadProduct(
                        category: categoryProvider.selectedCategory,
                        restaurantId: userProvider.restaurant.id,
                        restaurant: userProvider.restaurant.name)) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Upload Failed"),
                        duration: Duration(seconds: 3),
                      ));
                    } else {
                      productProvider.clear();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Upload completed"),
                        duration: Duration(seconds: 3),
                      ));
                      userProvider.loadProductsByRestaurant(
                          restaurantId: userProvider.restaurant.id);
                      await userProvider.reload();
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
