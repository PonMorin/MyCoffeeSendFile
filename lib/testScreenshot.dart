import 'dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'menuDynamicV4.dart';

class TestOnline extends StatefulWidget {
  TestOnline({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TestOnlineState createState() => _TestOnlineState();
}

class _TestOnlineState extends State<TestOnline> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

   List<String> imgBill = [
    "images/coffee.png",
    "images/checked.png",
    "images/logo2.PNG",
    "images/storeName.JPG",
    "images/Test.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        backgroundColor: Color(0xffEED9B9),
        bottomNavigationBar: BottomAppBar(
          //color: Color(0xffEED9B9),
          child: Container(
            height: 65.0,
            child: RaisedButton.icon(
              onPressed: () {
                 _imageFile = null;
          screenshotController
              .capture(delay: Duration(milliseconds: 10))
              .then((File image) async {
            //print("Capture Done");
            setState(() {
              _imageFile = image;
            });
            final result =
                await ImageGallerySaver.saveImage(image.readAsBytesSync());
            print("File Saved to Gallery");
          }).catchError((onError) {
            print(onError);
          });
                _backtomenu();
              },
              color: Color(0xff623B28),
            icon: Icon(
              Icons.camera,
              size: 35,
              color: Colors.white,
            ),
            label: Text("Screenshot",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                )),
          ),
        ),
        ),
             

      body: Container(
        child: new Center(
          child: Column(
            children: <Widget>[
              Screenshot(
                  controller: screenshotController,
                  child: Container(
                    child: Padding(padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(90.0),
                                topRight: Radius.circular(90.0),
                                bottomLeft: Radius.circular(90.0),
                                bottomRight: Radius.circular(90.0),
                              )),
                          height: 650.0,
                          width: double.infinity,
                          child: Column(children: <Widget>[
                            Center(
                              child: Image.asset(
                                imgBill[1],
                                scale: 8.0,
                              ),
                            ),
                            Center(
                              child: Text(
                                "Payment Completed",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff623B28),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                              child: Row(children: [
                                SizedBox(
                                  width: 18.0,
                                ),
                                Text(
                                  "Item",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff623B28),
                                  ),
                                ),
                                SizedBox(
                                  width: 125.0,
                                ),
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff623B28),
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              child: Row(children: [
                                SizedBox(
                                  width: 50.0,
                                ),
                                Text(
                                  "Item",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff623B28),
                                  ),
                                ),
                                SizedBox(
                                  width: 160.0,
                                ),
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff623B28),
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              child: Row(children: [
                                SizedBox(
                                  width: 40.0,
                                ),
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff623B28),
                                  ),
                                ),
                                SizedBox(
                                  width: 140.0,
                                ),
                                Text(
                                  "Price",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff623B28),
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(height: 50.0),
                            Container(
                              child: Text(
                                "Queue 46",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff623B28),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              child: Text(
                                "Thank you for purchase MYCOFFEE",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff623B28),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                                child: Column(children: <Widget>[
                              Image.asset(
                                imgBill[0],
                                width: 58.0,
                              ),
                              Text(
                                " Mycoffee",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff623B28),
                                ),
                              )
                            ]))
                          ]),
                         
                        ),
                    ),
                  ),
                ),
               // _imageFile != null ? Image.file(_imageFile) : Container(),
            ],
          ),
             
        ),
      ),
      
    );
  }

  _saved(File image) async {
    final result = await ImageGallerySaver.saveImage(image.readAsBytesSync());
    print("File Saved to Gallery");
  }

  void _backtomenu() async {
    final user4 = _auth.currentUser;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return MenuDynamic4(user: user4);
    }));
  }
}

