import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery_rest/models/order.dart';
import 'package:rocket_delivery_rest/providers/user.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.reload();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "Orders",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: ListView.builder(
            itemCount: userProvider.orders.length,
            itemBuilder: (_, index) {
              OrderModel _order = userProvider.orders[index];
              return ListTile(
                onTap: () {
                  String message = "";
                  for (int i = 0; i < _order.cart.length; i++) {
                    message += _order.cart[i]['name'] +
                        " - " +
                        _order.cart[i]['quantity'].toString() +
                        "\n";
                  }
                  message += "\nTotal: \$" + _order.total.toString();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: Text("Order"),
                          content: Text(message),
                        );
                      });
                },
                leading: Text(
                  "\$${_order.total}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                title: Text(_order.description),
                subtitle: Text(DateFormat('HH:mm dd/MM/yyyy').format(
                    DateTime.fromMillisecondsSinceEpoch(_order.createdAt))),
                trailing:
                    Text(_order.status, style: TextStyle(color: Colors.green)),
              );
            }));
  }
}
