/*import 'package:flutter/material.dart';
import 'package:mycoffe/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycoffe/Login2.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff623B28)),
        backgroundColor: Color(0xffEED9B9),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
          child: IconButton(
              icon: Icon(Icons.cancel),
              iconSize: 29.0,
              color: Color(0xff623B28),
              onPressed: () {
                backtoMenu();
              }),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                      height: 210.0,
                      child: Image.asset("images/drinkCoffee.jpg")),
                  Container(
                      height: 80.0, 
                      child: Image.asset("images/user.png"),
                    ),
                  SizedBox(height: 10.0),
                  Container(
                      width: 350.0,
                      decoration: BoxDecoration(color: Colors.white,
                          // borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300],
                                offset: Offset(2, 1),
                                blurRadius: 5)
                          ]),
                      child: ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(
                              hintText: "User", border: InputBorder.none),
                          /* validator: (String val) {
                                    if (val.isEmpty) {
                                      return "Please enter your email";
                                    }
                                    return null;
                                  },*/
                        ),
                      )),
                  SizedBox(height: 10.0),
                  Container(
                      width: 350.0,
                      decoration: BoxDecoration(color: Colors.white,
                          // borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300],
                                offset: Offset(2, 1),
                                blurRadius: 5)
                          ]),
                      child: ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Email", border: InputBorder.none),
                          /* validator: (String val) {
                                    if (val.isEmpty) {
                                      return "Please enter your email";
                                    }
                                    return null;
                                  },*/
                        ),
                      )),
                  SizedBox(height: 40.0),
                  Container(
                      child: GestureDetector(
                          child: Text("Logout",
                              style: TextStyle(
                                color: Color(0xff623B28),
                                fontFamily: "Roboto",
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              )),
                          onTap: () async {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_){
                              return LoginPage2();
                            }));
                          }))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void backtoMenu() async {
    final user5 = _auth.currentUser;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return Menu(user: user5);
    }));
  }

  Future _signOut() async {
    await _auth.signOut();
  }
}
*/