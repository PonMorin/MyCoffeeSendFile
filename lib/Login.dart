import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEED9B9),
        body: Stack(children: [
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 50.0,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Sign In",
                        style: TextStyle(
                          color: Color(0xff623B28),
                          fontSize: 30.0,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(
                          child: Column(children: <Widget>[
                            Container(
                              height: 50,
                              width: 280,
                              child: SignInButton(
                                Buttons.Email,
                                text: "  Sign in with Email",
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              height: 50,
                              width: 280,
                              child: SignInButton(
                                Buttons.Google,
                                text: "  Sign in with Google",
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              height: 50,
                              width: 280,
                              child: SignInButton(
                                Buttons.FacebookNew,
                                text: "  Sign in with Facebook",
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(height: 80.0),
                            Container(
                              height: 230,
                              width: 280,
                              child: Image(image: AssetImage("images/cup.png")),
                            )
                          ]),
                        ),
                      )
                    ])),
          )
        ]));
  }
}
