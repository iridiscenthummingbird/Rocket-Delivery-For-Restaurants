import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery_rest/providers/user.dart';
import 'package:rocket_delivery_rest/screens/login.dart';
import 'package:rocket_delivery_rest/screens/orders.dart';
import 'package:rocket_delivery_rest/screens/products.dart';
import 'package:rocket_delivery_rest/screens/settings.dart';
import 'package:rocket_delivery_rest/services/screen_navigation.dart';
import 'package:transparent_image/transparent_image.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.reload();
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              elevation: 0.5,
              backgroundColor: Colors.red,
              title: Text(
                "Rocket Delivery Restaurants",
                style: TextStyle(color: Colors.white),
              )),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.red),
                  accountName: Text(
                    userProvider.restaurant?.name ?? "Name",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  accountEmail: Text(
                    userProvider.user.email ?? "Email",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.restaurant),
                  title: Text("My restaurant"),
                ),
                ListTile(
                  onTap: () {
                    changeScreen(context, OrdersScreen());
                  },
                  leading: Icon(Icons.bookmark_border),
                  title: Text("Orders"),
                ),
                ListTile(
                  onTap: () {
                    changeScreen(context, ProductsScreen());
                  },
                  leading: Icon(Icons.fastfood),
                  title: Text("Products"),
                ),
                ListTile(
                  onTap: () {
                    changeScreen(context, SettingsScreen());
                  },
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                ),
                ListTile(
                  onTap: () {
                    userProvider.signOut();
                    changeScreen(context, LoginScreen());
                  },
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Log out"),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
              child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                      ),
                      child: imageWidget(
                          hasImage: userProvider.hasImage,
                          url: userProvider.restaurant.image)),

                  // fading black
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(2),
                          bottomRight: Radius.circular(2),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        )),
                  ),

                  //restaurant name
                  Positioned.fill(
                      bottom: 30,
                      left: 10,
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            userProvider?.restaurant?.name ?? "Name",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.normal),
                          ))),

                  // average price
                  Positioned.fill(
                      bottom: 10,
                      left: 10,
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Average Price: \$ ${userProvider.restaurant.avgPrice}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ))),

                  Positioned.fill(
                      bottom: 2,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow[900],
                                    size: 20,
                                  ),
                                ),
                                Text("${userProvider.restaurant.rating}"),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300],
                                offset: Offset(-2, -1),
                                blurRadius: 5),
                          ]),
                      child: ListTile(
                        onTap: () {
                          changeScreen(context, OrdersScreen());
                        },
                        title: Text(
                          "Orders",
                          style: TextStyle(fontSize: 24),
                        ),
                        trailing: Text(
                          userProvider.orders.length.toString(),
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: ListTile(
                      onTap: () {
                        changeScreen(context, ProductsScreen());
                      },
                      title: Text("Products", style: TextStyle(fontSize: 24)),
                      trailing: Text(userProvider.products.length.toString(),
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}

Widget imageWidget({bool hasImage, String url}) {
  if (hasImage) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: url,
      height: 160,
      fit: BoxFit.fill,
      width: double.infinity,
    );
  } else {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                size: 40,
              ),
            ],
          ),
          Text("No Photo")
        ],
      ),
      height: 160,
    );
  }
}
