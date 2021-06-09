import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery_rest/providers/user.dart';
import 'package:rocket_delivery_rest/screens/dashboard.dart';
import 'package:rocket_delivery_rest/screens/register.dart';
import 'package:rocket_delivery_rest/services/screen_navigation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/logo.png",
                    width: 128,
                    height: 128,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Rocket Delivery',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 32.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'For The Restaurants',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //EMAIL Field
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: authProvider.email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          icon: Icon(Icons.email)),
                    ),
                  ),
                ),
              ),
              //PASSWORD Field
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: authProvider.password,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          icon: Icon(Icons.lock)),
                    ),
                  ),
                ),
              ),
              //SIGN-IN Button
              ElevatedButton(
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    if (await authProvider.signIn(context)) {
                      authProvider.clearController();
                      changeScreen(context, DashboardScreen());
                    }
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.only(
                              left: 30, right: 30, top: 12, bottom: 12)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0))))),
              //REGISTER Button
              TextButton(
                  onPressed: () {
                    changeScreen(context, RegisterScreen());
                  },
                  child: Text(
                    'Register here',
                    style: TextStyle(color: Colors.grey),
                  ),
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.red[50]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)))))
            ],
          ),
        ),
      ),
    );
  }
}
