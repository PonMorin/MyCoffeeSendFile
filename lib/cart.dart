import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'payment.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllCart extends StatefulWidget {
  @override
  _AllCartState createState() => _AllCartState();
}

class _AllCartState extends State<AllCart> {
  var cart = FlutterCart();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    //_product();
    return Scaffold(
        backgroundColor: Colors.white /*Color(0xffEED9B9)*/,
        appBar: AppBar(
          title: Text('Your Cart',
              style: TextStyle(
                fontFamily: "Roboto",
                color: Color(0xff623B28),
              )),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
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
          //color: Color(0xffEED9B9),
          child: Container(
            height: 65.0,
            child: RaisedButton.icon(
              onPressed: () {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Are You Sure",
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
                        _incrementCounter;
                        if (cart.cartItem.isNotEmpty) {
                          List menu = [];
                          for (int i = 0; i < cart.cartItem.length; i++) {
                            menu.add({
                              "item": cart.cartItem.toList()[i].productId,
                              "price": cart.cartItem.toList()[i].unitPrice,
                              "qty": cart.cartItem.toList()[i].quantity,
                            });
                          }
                          await FirebaseFirestore.instance
                              .collection('getOrder')
                              .add({
                            "Menu": FieldValue.arrayUnion(menu),
                            "Total": cart.getTotalAmount(),
                            "Queue": _counter,
                            "Date": DateTime.now(),
                          });
                          cart.cartItem.clear();
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => PayMent()));
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
              label: Text("PURCHASE",
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
            /*  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                  )
                ),*/
            //height: 800,
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

              /* ListView.builder(
                         itemCount: cart.cartItem.length,
                         itemBuilder: (context, index) {
                           final item = cart.cartItem[index];
                           return Dismissible(
                             key: Key(item),
              // Provide a function that tells the app
              // what to do after an item has been swiped away.
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  cart.cartItem.removeAt(index);
                });
                             child: ListTile(title: Text('$item')),
                        );
                         }
                      ),*/

              SizedBox(height: 450),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                /*child:Container(
                          decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                  )
                ),*/
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        color: Color(0xff623B28),
                      ),
                    ),
                    Text(
                      "${cart.getTotalAmount()}",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        color: Color(0xff623B28),
                      ),
                    )
                  ],
                ),
              )
              //  )
            ]),
          )
        ])));
  }
}
