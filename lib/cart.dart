import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'payment.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'menuDynamicV4.dart';
class AllCart extends StatefulWidget {
  final User user;

  const AllCart({Key key, this.user}) : super(key: key);
  @override
  _AllCartState createState() => _AllCartState();
}

class _AllCartState extends State<AllCart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  

  var cart = FlutterCart();

  final userName = new TextEditingController();

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white /*Color(0xffEED9B9)*/,
        appBar: AppBar(
          title: Text('Your Cart',
              style: TextStyle(
                fontFamily: "Roboto",
                color: Color(0xff623B28),
              )),
          leading: IconButton(
            onPressed: () {
              _backtoMenu();
            },
            icon: Icon(Icons.arrow_back),
            color: Color(0xff623B28),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.delete),
                color: Color(0xff623B28),
                onPressed: () {
                  setState(() {
                    cart.cartItem.clear();
                  });
                })
          ],
          backgroundColor: Color(0xffEED9B9),
          elevation: 0.0,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 65.0,
            child: RaisedButton.icon(
              onPressed: () {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Are You Sure",
                  // content: Form(
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       TextFormField(
                  //         controller: userName,
                  //         decoration: InputDecoration(
                  //             hintText: "Please Enter Yourname"),
                  //         validator: (String val) {
                  //           if (val.isEmpty) {
                  //             return ("Enter name");
                  //           }
                  //           return null;
                  //         },
                  //       )
                  //     ],
                  //   ),
                  // ),
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Cancle",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Color(0xffFF6767),
                    ),
                    DialogButton(
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        if (cart.cartItem.isNotEmpty) {
                          List menu = [];
                          for (int i = 0; i < cart.cartItem.length; i++) {
                            menu.add({
                              "item": cart.cartItem.toList()[i].productId,
                              "price": cart.cartItem.toList()[i].unitPrice,
                              "qty": cart.cartItem.toList()[i].quantity,
                              "size": cart.cartItem.toList()[i].uniqueCheck,
                              "note": cart.cartItem.toList()[i].productDetails,
                            });
                          }
                          await FirebaseFirestore.instance
                              .collection('getOrder')
                              .add({
                            "Menu": FieldValue.arrayUnion(menu),
                            "Total": cart.getTotalAmount(),
                            // "Date": DateTime.now(),
                            "User": widget.user.displayName,
                            // "Email":widget.user.email,
                          });
                          //cart.cartItem.clear();
                          //userName.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PayMent()));
                        }
                      },
                      color: Color(0xff99DC79),
                    ),
                  ],
                ).show();
              },
              color: Color(0xff623B28),
              icon: Icon(
                Icons.account_balance_wallet,
                size: 25,
                color: Colors.white,
              ),
              label: Text("PURCHASE(Totoal:${cart.getTotalAmount()})",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  )),
            ),
          ),
        ),
        body: SafeArea(
            child: ListView(children: <Widget>[
          Container(
            width: double.infinity,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 38.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "item",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff623B28),
                        ),
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
              SizedBox(height: 5.0),
              Container(
                padding: EdgeInsets.fromLTRB(33.0, 0.0, 30.0, 0.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        for (var item in cart.cartItem)
                          Text(
                            "${item.productId}",
                            style: TextStyle(
                                color: Color(0xff623B28),
                                fontSize: 15.0,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold),
                          ),
                      ]),
                      Container(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),
                          child: Column(
                            children: [
                              for (var item in cart.cartItem)
                                Text(
                                  "${item.unitPrice * item.quantity}",
                                  style: TextStyle(
                                      color: Color(0xff623B28),
                                      fontSize: 15.0,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold),
                                ),
                            ],
                          )),
                    ]),
              ),
            ]),
          )
        ])));
  }

  void _backtoMenu() async {
    final user4 = _auth.currentUser;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return MenuDynamic4(user: user4);
    }));
  }
}
