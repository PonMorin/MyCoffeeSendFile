import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:screenshot/screenshot.dart';
import 'menuDynamicV4.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io';

class Cash extends StatefulWidget {
  final User user;

  const Cash({Key key, this.user}) : super(key: key);
  @override
  _CashState createState() => _CashState();
}

class _CashState extends State<Cash> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey imageKey = GlobalKey();

  var cart = FlutterCart();
  File _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  List<String> imgBill = [
    "images/coffee.png",
    "images/checked.png",
    "images/logo2.PNG",
    "images/storeName.JPG"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffEED9B9),
        iconTheme: IconThemeData(color: Color(0xff623B28)),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              _backtomenu();
              cart.cartItem.clear();
            },
          )
        ],
      ),
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

              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text("Screenshot Success"),
              ));
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
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Center(
              child: Column(
            children: [
              Screenshot(
                controller: screenshotController,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
                  child: Container(
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
                        padding: const EdgeInsets.only(top:10.0),
                        child: Center(
                          
                              child:Column(
                                children: <Widget>[
                                  for (var item in cart.cartItem)
                                    Text(
                                      "${item.productId} x${item.quantity}  ${item.unitPrice}",
                                      style: TextStyle(
                                          color: Color(0xff623B28),
                                          fontSize: 15.0,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.bold),
                                    ),
                                ],
                              ),
                             
                          
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Center(
                          child: Container(
                            child: Text(
                              "Total ${cart.getTotalAmount()}",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff623B28),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Center(
                          child: Container(
                            child: Text(
                              "${widget.user.displayName}",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff623B28),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Center(
                        child: Container(
                          child: Text(
                            "โปรดแสดงหลักฐานก่อนรับสินค้า",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff623B28),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        child: Text(
                          "Thank you for purchase MYCOFFEE",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff623B28),
                          ),
                        ),
                      ),
                      SizedBox(height: 120.0),
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
              // _imageFile != null ? Image.file(_imageFile) : Container(),
            ],
          ))
        ],
      )),
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
