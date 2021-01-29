import 'package:flutter/material.dart';
import 'package:mycoffe/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cart/flutter_cart.dart';

class Cash extends StatefulWidget {
  @override
  _CashState createState() => _CashState();
}

class _CashState extends State<Cash> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var cart = FlutterCart();

  List<String> imgBill = [
    "images/coffee.png",
    "images/checked.png",
    "images/logo2.PNG",
    "images/storeName.JPG"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:  _scaffoldKey,
      backgroundColor: Color(0xffEED9B9),
      /*appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child:Text('Payment', 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Roboto",
              color: Color(0xff623B28),
            )),
       /* leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Color(0xff623B28),*/
        ),
        backgroundColor: Color(0xffEED9B9),
        elevation: 0.0,
      ),*/
      bottomNavigationBar: BottomAppBar(
        //color: Color(0xffEED9B9),
        child: Container(
          height: 65.0,
          child: RaisedButton.icon(
            onPressed: () {
              _screenShot();
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Menu(user: user,)),
              );*/
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
          Padding(padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0)),
          Container(
             decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(90.0),
                  topRight: Radius.circular(90.0),
                  bottomLeft: Radius.circular(90.0),
                  bottomRight: Radius.circular(90.0),
                )),
            height: 720.0,
            child: Column(children: <Widget>[
              Center(child:Image.asset(
                imgBill[1],
                scale: 8.0,
              ),),
              Center(child:Text(
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
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
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
                    width: 130.0,
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
                    width: 165.0,
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
                    width: 145.0,
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
              SizedBox(height: 70.0),
              Container(
                child: Text(
                  "46",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff623B28),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
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
              SizedBox(height: 15.0),
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
              SizedBox(height: 160.0),
              Container(
                  child: Column(children: <Widget>[
                    Image.asset(
                      imgBill[0],
                      width: 100.0,
                    ),
                    
                    Text(" Mycoffee",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff623B28),
                  ),)
                 
                  ]))
            ]),
          /*  decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(90.0),
                  topRight: Radius.circular(90.0),
                  bottomLeft: Radius.circular(90.0),
                  bottomRight: Radius.circular(90.0),
                )),*/
          )
        ],
      ),
      ),
    );
  }

  void _screenShot() async {
      final user2 = _auth.currentUser;
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                return Menu(user: user2);
              }));
    }


}
