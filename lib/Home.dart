import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mycoffe/Login2.dart';
import 'package:mycoffe/untillity/myStyle.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage2())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEED9B9),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyStyle().logoMain(),
              MyStyle().storeName("MyCoffee"),
            ],
          ),
        ));
  }
}
