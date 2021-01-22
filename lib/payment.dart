import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycoffe/cash_bill.dart';
import 'package:mycoffe/online_bank.dart';
import 'package:flutter_cart/flutter_cart.dart';

class PayMent extends StatefulWidget {
  @override
  _PayMentState createState() => _PayMentState();
}

class _PayMentState extends State<PayMent> {

  var cart = FlutterCart();

  List<String> imgIcon = [
    "images/cash.png",
    "images/online.png",
  ];

 /* void _product() {
    List list = [];
    for(var items in cart.cartItem)
        list.add(items.productId) ;
    print(list);
  }*/


  @override
  Widget build(BuildContext context) {
    //_product();
    return Scaffold(
      backgroundColor: Color(0xffEED9B9),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Color(0xff623B28),
        ),
        title: Text('PAYMENT',
            style: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              color: Color(0xff623B28),
            )),
        backgroundColor: Color(0xffEED9B9),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 1.0),
                  child: Container(
                      padding: EdgeInsets.all(20.0),
                      height: 135,
                      width: 350,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Cash()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: menuPay("Cash", imgIcon[0]),
                        ))),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.all(20.0),
                    height: 135,
                    width: 350,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Online()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: menuPay("Online Banking", imgIcon[1]),
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget menuPay(String payMenu, String iconImg) {
  var cart = FlutterCart();

  
  List list = [];
    for(var items in cart.cartItem)
        list.add(items.productId) ;
    print(list);
  

  return Padding(
      padding: EdgeInsets.all(16.0),
      child: GestureDetector(
       /* onTap: () {
          
        },*/
        child: Column(children: <Widget>[
          Expanded(
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  payMenu,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff623B28),
                  ),
                ),
                SizedBox(height: 5.0),
                Container(
                    width: 70.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill, image: AssetImage(iconImg)))),
              ],
            ),
          ),
        ]),
      ));
}

