import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycoffe/ProductModel/bakery.dart';
import 'package:mycoffe/ProductModel/coffee.dart';
import 'package:mycoffe/ProductModel/milkChocolate.dart';
import 'package:mycoffe/ProductModel/recommend.dart';
import 'package:mycoffe/ProductModel/tea.dart';
import 'package:mycoffe/ProductModel/topic.dart';
import 'package:mycoffe/bakeryChoice.dart';
import 'searchingPage.dart';
import 'choice.dart';
import 'package:mycoffe/choice.dart';
import 'cart.dart';
import 'package:mycoffe/Login2.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'ProductModel/coffee.dart';
import 'dart:async';

class MenuDynamic4 extends StatefulWidget {
  final User user;

  const MenuDynamic4({Key key, this.user}) : super(key: key);
  @override
  _MenuDynamic4State createState() => _MenuDynamic4State();
}

class _MenuDynamic4State extends State<MenuDynamic4> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  var cart = FlutterCart();
  var comment;

  final allComment = new TextEditingController();

  //Product length//

  final coffeeCollection = FirebaseFirestore.instance.collection('coffee');
  final recommendCollection =
      FirebaseFirestore.instance.collection('RecommendV2');
  final teaCollection = FirebaseFirestore.instance.collection('Tea');
  final milkCollection = FirebaseFirestore.instance.collection('milk');
  final bakeryCollection = FirebaseFirestore.instance.collection('bakery');

  StreamSubscription recommendStream;
  StreamSubscription coffeeStream;
  StreamSubscription teaStream;
  StreamSubscription milkStream;
  StreamSubscription bakeryStream;

  List<Topic> topics = List();
  List<Recommend> recommend;
  List<AllCoffee> menus;
  List<Tea> menuTea;
  List<MilkChocolate> menuMilk;
  List<Bakery> menuBakery;

  @override
  void initState() {
    super.initState();

    recommendStream = recommendMenu().listen((model) {
      setState(() {
        recommend = model;
      });
    });
    coffeeStream = coffeeMenu().listen((model) {
      setState(() {
        menus = model;
      });
    });
    teaStream = teaMenu().listen((model) {
      setState(() {
        menuTea = model;
      });
    });
    milkStream = milkMenu().listen((model) {
      setState(() {
        menuMilk = model;
      });
    });
    bakeryStream = bakeryMenu().listen((model) {
      setState(() {
        menuBakery = model;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    recommendStream?.cancel();
  }

  Stream<List<Recommend>> recommendMenu() {
    return recommendCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((model) => Recommend.fromJson(model.data()))
          .toList();
    });
  }

  Stream<List<AllCoffee>> coffeeMenu() {
    return coffeeCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((model) => AllCoffee.fromJson(model.data()))
          .toList();
    });
  }

  Stream<List<Tea>> teaMenu() {
    return teaCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((model) => Tea.fromJson(model.data())).toList();
    });
  }

  Stream<List<MilkChocolate>> milkMenu() {
    return milkCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((model) => MilkChocolate.fromJson(model.data()))
          .toList();
    });
  }

  Stream<List<Bakery>> bakeryMenu() {
    return bakeryCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((model) => Bakery.fromJson(model.data()))
          .toList();
    });
  }
  //Product length//

  Future<void> everyComment(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: allComment,
                    validator: (value) {
                      return value.isNotEmpty ? null : "Invalid Field";
                    },
                    decoration: InputDecoration(hintText: "Comment"),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  "Send",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Color(0xff623B28),
                  ),
                ),
                onPressed: () async {
                  if (allComment.text.isNotEmpty) {
                    await FirebaseFirestore.instance.collection('comment').add({
                      'comment': allComment.text,
                    });
                    Navigator.of(context).pop();
                    allComment.clear();
                  }
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xff623B28)),
          //automaticallyImplyLeading: false,
          backgroundColor: Color(0xffEED9B9),
          centerTitle: true,
          title: Text('MyCoffee',
              style: TextStyle(
                fontFamily: "Roboto",
                color: Color(0xff623B28),
              )),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: IconButton(
                    icon: Icon(Icons.search),
                    color: Color(0xff623B28),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CloudFirestoreSearch()));
                    }))
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                color: Color(0xffEED9B9),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Text(
                          "user: ${widget.user.displayName}",
                          style: TextStyle(
                              color: Color(0xff623B28),
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "email: ${widget.user.email}",
                        style: TextStyle(
                            color: Color(0xff623B28),
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                    ]),
              ),
              SizedBox(
                height: 14.0,
              ),
              GestureDetector(
                  child: ListTile(
                      onTap: () async {
                        everyComment(context);
                      },
                      leading: Icon(Icons.comment),
                      title: Text(
                        "Comment",
                        style: TextStyle(
                            color: Color(0xff623B28),
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ))),
              SizedBox(
                height: 2.0,
              ),
              GestureDetector(
                  child: ListTile(
                      onTap: () async {
                        _signOut().whenComplete(() {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (_) {
                            return LoginPage2();
                          }));
                        });
                      },
                      leading: Icon(Icons.logout),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                            color: Color(0xff623B28),
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ))),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0.0, 260, 0.0, 0.0),
              //   child: Center(
              //     child: Container(
              //         height: 210.0,
              //         child: Image.asset("images/drinkCoffee.jpg")),
              //   ),
              // )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          //color: Color(0xffEED9B9),
          child: Container(
            height: 65.0,
            child: RaisedButton.icon(
              onPressed: () {
                _goToCart();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AllCart()),
                // );
              },
              color: Color(0xffEED9B9),
              icon: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Color(0xff623B28),
              ),
              label: Text("Cart",
                  style: TextStyle(
                    color: Color(0xff623B28),
                    fontSize: 35,
                  )),
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                Container(
                  child: SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 8.0, 0.0, 0.0),
                      child: Text(
                        "Recommend For You",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff623B28),
                          fontFamily: "RobotoMono",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ])),
                ),
                Container(
                  child: SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: firebaseFirestore
                                .collection("RecommendV2")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> querySnapshot) {
                              if (querySnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ));
                              } else {
                                final list = querySnapshot.data.docs;
                                String img = list[index]['image'];
                                String foodName = list[index]['name'];
                                int price = list[index]['price'];
                                return Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChoiceScreen(
                                                            menuImg: img,
                                                            foodName: foodName,
                                                            foodPrice: price,
                                                          )));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  img,
                                                  height: 80.0,
                                                  width: 120,
                                                ),
                                                Text(
                                                  foodName,
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xff623B28)),
                                                ),
                                                Text(
                                                  "${price}",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                );
                              }
                            });
                      }, childCount: recommend != null ? recommend.length : 0)),
                ),
                Container(
                  child: SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
                      child: Text(
                        "Coffee",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff623B28),
                          fontFamily: "RobotoMono",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ])),
                ),
                Container(
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: firebaseFirestore
                                .collection("coffee")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> querySnapshot) {
                              if (querySnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ));
                              } else {
                                final list = querySnapshot.data.docs;
                                String img = list[index]['image'];
                                String foodName = list[index]['name'];
                                int price = list[index]['price'];

                                return Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChoiceScreen(
                                                          menuImg: img,
                                                          foodName: foodName,
                                                          foodPrice: price,
                                                        )));
                                          },
                                          child: Row(children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    foodName,
                                                    style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xff623B28),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.0),
                                                  Text(
                                                    "${price}",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontFamily: "Roboto",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                width: 70.0,
                                                height: 70.0,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            img)))),
                                          ]),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Container(
                                          height: 1.0,
                                          width: 600.0,
                                          color: Colors.grey[400]),
                                    ),
                                  ],
                                );
                              }
                            });
                      },
                      childCount: menus != null ? menus.length : 0,
                    ),
                  ),
                ),
                Container(
                  child: SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
                      child: Text(
                        "Tea",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff623B28),
                          fontFamily: "RobotoMono",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ])),
                ),
                Container(
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return StreamBuilder<QuerySnapshot>(
                            stream:
                                firebaseFirestore.collection("Tea").snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> querySnapshot) {
                              if (querySnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ));
                              } else {
                                final list = querySnapshot.data.docs;
                                String img = list[index]['image'];
                                String foodName = list[index]['name'];
                                int price = list[index]['price'];

                                return Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChoiceScreen(
                                                          menuImg: img,
                                                          foodName: foodName,
                                                          foodPrice: price,
                                                        )));
                                          },
                                          child: Row(children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    foodName,
                                                    style: TextStyle(
                                                      fontFamily: "Roboto",
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xff623B28),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.0),
                                                  Text(
                                                    "${price}",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontFamily: "Roboto",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                width: 70.0,
                                                height: 70.0,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            img)))),
                                          ]),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Container(
                                          height: 1.0,
                                          width: 600.0,
                                          color: Colors.grey[400]),
                                    ),
                                  ],
                                );
                              }
                            });
                      },
                      childCount: menuTea != null ? menuTea.length : 0,
                    ),
                  ),
                ),
                Container(
                  child: SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
                      child: Text(
                        "Milk & Chocolate",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff623B28),
                          fontFamily: "RobotoMono",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ])),
                ),
                Container(
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return StreamBuilder<QuerySnapshot>(
                          stream:
                              firebaseFirestore.collection("milk").snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> querySnapshot) {
                            if (querySnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ));
                            } else {
                              final list = querySnapshot.data.docs;
                              String img = list[index]['image'];
                              String foodName = list[index]['name'];
                              int price = list[index]['price'];

                              return Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChoiceScreen(
                                                        menuImg: img,
                                                        foodName: foodName,
                                                        foodPrice: price,
                                                      )));
                                        },
                                        child: Row(children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  foodName,
                                                  style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff623B28),
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  "${price}",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              width: 70.0,
                                              height: 70.0,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image:
                                                          NetworkImage(img)))),
                                        ]),
                                      )),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Container(
                                        height: 1.0,
                                        width: 600.0,
                                        color: Colors.grey[400]),
                                  ),
                                ],
                              );
                            }
                          });
                    }, childCount: menuMilk != null ? menuMilk.length : 0),
                  ),
                ),
                Container(
                  child: SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
                      child: Text(
                        "Bakery",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff623B28),
                          fontFamily: "RobotoMono",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ])),
                ),
                Container(
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: firebaseFirestore
                              .collection("bakery")
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> querySnapshot) {
                            if (querySnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ));
                            } else {
                              final list = querySnapshot.data.docs;
                              String img = list[index]['image'];
                              String foodName = list[index]['name'];
                              int price = list[index]['price'];

                              return Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BakeryChoice(
                                                        imgMenu: img,
                                                        nameFood: foodName,
                                                        priceFood: price,
                                                      )));
                                        },
                                        child: Row(children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  foodName,
                                                  style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff623B28),
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  "${price}",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              width: 70.0,
                                              height: 70.0,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image:
                                                          NetworkImage(img)))),
                                        ]),
                                      )),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Container(
                                        height: 1.0,
                                        width: 600.0,
                                        color: Colors.grey[400]),
                                  ),
                                ],
                              );
                            }
                          });
                    }, childCount: menuBakery != null ? menuBakery.length : 0),
                  ),
                ),
              ],
            )
          ]),
        ));
  }

  Future _signOut() async {
    await _auth.signOut();
  }

  void _goToCart() async {
    final user4 = _auth.currentUser;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return AllCart(user: user4);
    }));
  }
}
