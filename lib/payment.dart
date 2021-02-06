import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mycoffe/cash_bill.dart';
import 'package:mycoffe/online_bank.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:mycoffe/testScreenshot.dart';

class PayMent extends StatefulWidget {
  @override
  _PayMentState createState() => _PayMentState();
}

class _PayMentState extends State<PayMent> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
        child: StreamBuilder<QuerySnapshot>(
            stream: firebaseFirestore.collection("payMent").snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> querysnapshot) {
              return (querysnapshot.connectionState == ConnectionState.waiting)
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: querysnapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        var payment = querysnapshot.data.docs[index];
                        return GestureDetector(
                            onTap: () {
                              if (payment["paymentType"] == "Cash") {
                                final user4 = _auth.currentUser;
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return Cash(user: user4);
                                }));
                              } else if (payment["paymentType"] ==
                                  "Online Banking") {
                                final user4 = _auth.currentUser;
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return Online(user: user4);
                                }));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(payment["paymentType"],
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff623B28),
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Image.network(
                                        payment["image"],
                                        height: 60.0,
                                        //scale: 8.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      });
              // return ListView(
              //   children: <Widget>[
              //     SizedBox(
              //       height: 10,
              //     ),
              //     Column(
              //       children: <Widget>[
              //         Padding(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 15.0, vertical: 1.0),
              //           child: Container(
              //               padding: EdgeInsets.all(20.0),
              //               height: 135,
              //               width: 350,
              //               child: GestureDetector(
              //                 onTap: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(builder: (context) => Cash()),
              //                   );
              //                 },
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                       color: Colors.white,
              //                       borderRadius: BorderRadius.circular(16)),
              //                   child: menuPay("Cash", imgIcon[0]),
              //                 ))),
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Container(
              //             padding: EdgeInsets.all(20.0),
              //             height: 135,
              //             width: 350,
              //             child: GestureDetector(
              //                 onTap: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(builder: (context) => Online()),
              //                   );
              //                 },
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                       color: Colors.white,
              //                       borderRadius: BorderRadius.circular(16)),
              //                   child: menuPay("Online Banking", imgIcon[1]),
              //                 ))),
              //       ],
              //     ),
              //   ],
              // );
            }),
      ),
    );
  }

  void _goToCart() async {
    final user4 = _auth.currentUser;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return Cash(user: user4);
    }));
  }
}

Widget menuPay(String payMenu, String iconImg) {
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
