import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycoffe/menu.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycoffe/menuDynamic.dart';
import 'package:mycoffe/menuDynamicV3.dart';
import 'package:mycoffe/menuDynamicV4.dart';

class ChoiceScreen extends StatefulWidget {
  final menuImg;
  final foodName;
  final foodPrice;

  ChoiceScreen({this.menuImg, this.foodName, this.foodPrice});

  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool statusSizeCup = false;
  bool statusSizeCup2 = false;
  bool statusSizeCup3 = false;

  var advice;

  final allAdvice = new TextEditingController();

  int _qty = 1;

  void _add() {
    setState(() {
      _qty += 1;
    });
  }

  void _remove() {
    setState(() {
      if (_qty > 1) _qty -= 1;
    });
  }

  var cart = FlutterCart();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffEED9B9),
      /*  appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Color(0xff623B28),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),*/

      bottomNavigationBar: BottomAppBar(
        //color: Color(0xffEED9B9),
        child: Container(
          height: 65.0,
          child: RaisedButton.icon(
            onPressed: () async {
              if(statusSizeCup == false && statusSizeCup2 == false && statusSizeCup3 == false){
                showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
           title: Text(
                  "Please Choose Sized",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Color(0xff623B28),
                  ),
                ),
            actions: [
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Color(0xff623B28),
                  ),
                ),
                onPressed: () async {
                  
                    Navigator.of(context).pop();
                   
                  },
              )
            ],
          );
        });
    
              }
              if(statusSizeCup == true || statusSizeCup2 == true || statusSizeCup3 == true){
              _backtomenu();
              }
              // if(allAdvice.text.isNotEmpty){
              //   await FirebaseFirestore.instance.collection('NoteAddvice').add({
              //       'note': allAdvice.text,
              //    });
              // }
            },
            color: Color(0xff623B28),
            icon: Icon(
              Icons.shopping_cart,
              size: 25,
              color: Colors.white,
            ),
            label: Text("Add to Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                )),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Stack(children: <Widget>[
              Center(
                child: Container(
                    width: 500.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(widget.menuImg)))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(left: 5.0),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Color(0xff623B28),
                  )
                ],
              ),
            ]),
            //  SizedBox(height: 20.0),
            Container(
                height: 80.0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.foodName,
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff623B28),
                                ),
                              ),
                              Text(
                                "${widget.foodPrice}",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff623B28),
                                ),
                              ),
                            ]),
                      ),
                      Text("Start Price",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ))
                    ]),
                decoration: BoxDecoration(
                  color: Colors.white,
                )),

            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Wrap(
                      children: <Widget>[
                        Text("Size",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              color: Color(0xff623B28),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Text("+0"),
                          IconButton(
                              icon: statusSizeCup
                                  ? Icon(Icons.free_breakfast)
                                  : Icon(Icons.free_breakfast_outlined),
                              color: Color(0xff623B28),
                              onPressed: () {
                                setState(() {
                                  statusSizeCup = !statusSizeCup;
                                  statusSizeCup2 = false;
                                  statusSizeCup3 = false;
                                });
                              }),
                        ],
                      ),
                      Column(
                        children: [
                          Text("+10"),
                          IconButton(
                              icon: statusSizeCup2
                                  ? Icon(Icons.free_breakfast)
                                  : Icon(Icons.free_breakfast_outlined),
                              color: Color(0xff623B28),
                              iconSize: 30.0,
                              onPressed: () {
                                setState(() {
                                  statusSizeCup2 = !statusSizeCup2;
                                  statusSizeCup = false;
                                  statusSizeCup3 = false;
                                });
                              }),
                        ],
                      ),
                      Column(
                        children: [
                          Text("+20"),
                          IconButton(
                              icon: statusSizeCup3
                                  ? Icon(Icons.free_breakfast)
                                  : Icon(Icons.free_breakfast_outlined),
                              color: Color(0xff623B28),
                              iconSize: 38.0,
                              onPressed: () {
                                setState(() {
                                  statusSizeCup3 = !statusSizeCup3;
                                  statusSizeCup2 = false;
                                  statusSizeCup = false;
                                });
                              }),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("More Advice",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            color: Color(0xff623B28),
                          )),
                      Text("Not required",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[300],
                          )),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 15.0),

            Container(
              height: 60.0,
              child: TextField(
                controller: allAdvice,
                decoration: InputDecoration(
                    hintText: "  Ex. No Sugar", border: InputBorder.none),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff623B28)),
              ),
            ),

            SizedBox(height: 10.0),

            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  )),
              height: 240.0,
              width: 60.0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff623B28),
                            ),
                          ),
                          Text(
                            "${widget.foodPrice * _qty} Bath",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              color: Color(0xff623B28),
                            ),
                          ),
                        ]),
                    SizedBox(height: 1.0),
                    Container(
                        child: Column(children: <Widget>[
                      Center(
                        child: Image.asset(
                          "images/logo3.JPG",
                          width: 100.0,
                        ),
                      )
                    ])),
                    SizedBox(height: 5.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.only(left: 55.0),
                            onPressed: _remove,
                            icon: Icon(Icons.remove_circle),
                            iconSize: 45.0,
                            color: Color(0xff623B28),
                          ),
                          _boxQuantity(_qty),
                          /*Text(_qty,
                               style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff623B28),
                                backgroundColor: Color(0xffEED9B9)
                              ),
                            ),*/

                          IconButton(
                            padding: EdgeInsets.only(right: 55.0),
                            onPressed: _add,
                            icon: Icon(Icons.add_circle),
                            iconSize: 45.0,
                            color: Color(0xff623B28),
                          ),
                        ])
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _boxQuantity(int qty) {
    return Container(
      height: 60.0,
      width: 60,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Color(0xffEED9B9),
        border: Border.all(color: Color(0xff623B28)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Text(
        qty.toString(),
        style: TextStyle(
            color: Color(0xff623B28),
            fontFamily: "Roboto",
            fontSize: 25.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  void _backtomenu() async {
    final user3 = _auth.currentUser;
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            if (allAdvice.text.isEmpty && statusSizeCup == true) {
              final sizeCup = "Small";
              cart.addToCart(
                  productId: widget.foodName,
                  unitPrice: widget.foodPrice,
                  quantity: _qty,
                  uniqueCheck: sizeCup);
            } else if (allAdvice.text.isEmpty && statusSizeCup2 == true) {
              final sizeCup = "Medium";
              final sumPrice = widget.foodPrice + 10;
              cart.addToCart(
                  productId: widget.foodName,
                  unitPrice: sumPrice,
                  quantity: _qty,
                  uniqueCheck: sizeCup);
            } else if (allAdvice.text.isEmpty && statusSizeCup3 == true) {
              final sizeCup = "Big";
              final sumPrice = widget.foodPrice + 20;
              cart.addToCart(
                  productId: widget.foodName,
                  unitPrice: sumPrice,
                  quantity: _qty,
                  uniqueCheck: sizeCup);
            } else if (allAdvice.text.isNotEmpty && statusSizeCup == true) {
              final sizeCup = "Small";
              cart.addToCart(
                  productId: widget.foodName,
                  unitPrice: widget.foodPrice,
                  quantity: _qty,
                  uniqueCheck: sizeCup,
                  productDetailsObject: allAdvice.text);
            } else if (allAdvice.text.isNotEmpty && statusSizeCup2 == true) {
              final sizeCup = "Medium";
              final sumPrice = widget.foodPrice + 10;
              cart.addToCart(
                  productId: widget.foodName,
                  unitPrice: sumPrice,
                  quantity: _qty,
                  uniqueCheck: sizeCup,
                  productDetailsObject: allAdvice.text);
            } else if (allAdvice.text.isNotEmpty && statusSizeCup3 == true) {
              final sizeCup = "Big";
              final sumPrice = widget.foodPrice + 20;
              cart.addToCart(
                  productId: widget.foodName,
                  unitPrice: sumPrice,
                  quantity: _qty,
                  uniqueCheck: sizeCup,
                  productDetailsObject: allAdvice.text);
            }
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return MenuDynamic4(user: user3);
            }));
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Icon(
                    Icons.check,
                    color: Color(0xff623B28),
                    size: 95.0,
                  ),
                ),
                Center(
                  child: Text(
                    "Added To Cart",
                    style: TextStyle(
                      color: Color(0xff623B28),
                      fontFamily: "Roboto",
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
