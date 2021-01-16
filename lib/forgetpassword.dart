import 'package:flutter/material.dart';
import 'package:mycoffe/Login2.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEED9B9),
        body: Stack(children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 50.0,
                  ),
                  child: Column(children: <Widget>[
                    Text(
                      "Sign In",
                      style: TextStyle(
                        color: Color(0xff623B28),
                        fontSize: 30.0,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: Container(
                          width: 600.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[300],
                                    offset: Offset(2, 1),
                                    blurRadius: 5)
                              ]),
                          child: ListTile(
                            title: TextField(
                              decoration: InputDecoration(
                                  hintText: "email@gmail.com",
                                  border: InputBorder.none),
                            ),
                          )),

                          
                    ),
                    SizedBox(height: 40.0 ),
                    Container(
                      width: 300.0,
                      height: 40.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color(0xff623B28))),
                        onPressed: () {
                          Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage2()));
                                          },
                        color: Color(0xff623B28),
                        textColor: Colors.white,
                        child: Text("Send to Email",
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),

                    SizedBox(height: 80.0),

                    Container(
                        height: 190.0, child: Image.asset("images/cup.png"))

                  ]
                  )
              )
          )
        ]
        )
      
    );
  }
}