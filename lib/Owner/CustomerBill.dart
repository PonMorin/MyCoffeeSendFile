import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ownerLogin.dart';

class Owner extends StatefulWidget {
  final User user;

  const Owner({Key key, this.user}) : super(key: key);
  @override
  _OwnerState createState() => _OwnerState();
}

class _OwnerState extends State<Owner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}