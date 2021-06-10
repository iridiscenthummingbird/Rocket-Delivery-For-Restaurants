import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rocket_delivery_rest/providers/user.dart';
import 'package:rocket_delivery_rest/widgets/custom_file_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: key,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Settings",
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
                  child: userProvider.restaurantImage == null
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
                                              userProvider.getImageFile(
                                                  source: ImageSource.gallery);
                                              Navigator.pop(context);
                                            }),
                                        new ListTile(
                                            leading: new Icon(Icons.camera_alt),
                                            title: new Text('Take a photo'),
                                            onTap: () async {
                                              userProvider.getImageFile(
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
                          child: Image.file(userProvider.restaurantImage)),
                ),
              ],
            ),
          ),
          Visibility(
            visible: userProvider.restaurantImage != null,
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
                                  userProvider.getImageFile(
                                      source: ImageSource.gallery);
                                  Navigator.pop(context);
                                }),
                            new ListTile(
                                leading: new Icon(Icons.camera_alt),
                                title: new Text('Take a photo'),
                                onTap: () async {
                                  userProvider.getImageFile(
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
                  controller: userProvider.name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Restaurant name",
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
                    if (!await userProvider.editRestaurant()) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Editing Failed"),
                        duration: Duration(seconds: 3),
                      ));
                    } else {
                      userProvider.clear();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Editing completed"),
                        duration: Duration(seconds: 3),
                      ));
                      await userProvider.reload();
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
