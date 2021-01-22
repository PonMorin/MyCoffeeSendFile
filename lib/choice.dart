import 'package:flutter/material.dart';
import 'package:mycoffe/menu.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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

  //var cart = TestClassPlugin();

  var cart = FlutterCart();

  /*List<Dish> _cartList = List<Dish>();
  List<Dish> _dishes = List<Dish>();*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:  _scaffoldKey,
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
          onPressed: () { 
            _backtomenu();
            /*await FirebaseFirestore.instance.collection('customer').add({
                'menu': widget.foodName.toList(),
                'price': widget.foodPrice,
                'qty': _qty,
                //'note':Get.arguments['note'],
             }).whenComplete(() {
              Get.snackbar("Dev", 
              "${Get.arguments[widget.foodName]}",
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM
              );
            });*/          
          },
          color: Color(0xff623B28),
          icon: Icon(
            Icons.shopping_cart,
            size: 35,
            color: Colors.white,
          ),
          label: Text("Add to Cart -${widget.foodPrice} ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
              )),
        ),
      ),
    ),

      body: ListView(
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
                          image: AssetImage(widget.menuImg)))),
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
              height: 67.0,
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
          SizedBox(height: 40.0),
          Row(
            children: [
              Text("More Advice",
                  style: TextStyle(
                    fontSize: 25.0,
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
          ),

          SizedBox(height: 25.0),

          Container(
            height: 60.0,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "  Ex. No Sugar", border: InputBorder.none),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xff623B28)),
            ),
          ),

          SizedBox(height: 30.0),

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
                          "${widget.foodPrice} Bath",
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
    );
  }

  Widget _boxQuantity(int qty) {
    return Container(
      height: 70,
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
                    cart.addToCart(productId: widget.foodName, unitPrice: widget.foodPrice, quantity: _qty);
                    Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return Menu(user: user3);
              }));
                  });
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    title: Icon(
                      Icons.check,
                      color: Color(0xff623B28),
                      size: 95.0,
                    ),
                    content: Text(
                      " Added To Your Cart  ",
                      style: TextStyle(
                        color: Color(0xff623B28),
                        fontFamily: "Roboto",
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                });
              
    }
 
}