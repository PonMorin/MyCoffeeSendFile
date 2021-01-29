import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'choice.dart';
import 'package:mycoffe/choice.dart';
import 'cart.dart';
import 'package:mycoffe/Login2.dart';
import 'package:flutter_cart/flutter_cart.dart';


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
                      showSearch(context: context, delegate: DataSearch());
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
                      Text(
                        "user: ${widget.user.displayName}",
                        style: TextStyle(
                            color: Color(0xff623B28),
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
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
                        _signOut().whenComplete(() {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(builder: (_) {
                            return LoginPage2();
                          }));
                        });
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
              SizedBox(height: 208.0),
              Center(
                child: Container(
                    height: 210.0,
                    child: Image.asset("images/drinkCoffee.jpg")),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          //color: Color(0xffEED9B9),
          child: Container(
            height: 65.0,
            child: RaisedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllCart()),
                );
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
                          maxCrossAxisExtent: 200,
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
                                                  height: 60.0,
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
                      }, childCount: 4)),
                ),
               /* Container(
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
                      childCount: menus.length,
                    ),
                  ),
                ),*/
               
              ],
            )
          ]),
        ));
  }

  Future _signOut() async {
    await _auth.signOut();
  }
}

class DataSearch extends SearchDelegate<String> {
  final menu = [
    "Espresso",
    "Black coffee",
    "Cappuccino.",
    "Cold brew",
    "Affogato",
    "Green tea leamon",
    "British tea",
    "Rose tea",
    "Buble tea",
    "Milk tea",
    "Milk Shake",
    "Hot Dark Chocolate",
    "Chocolate Cold",
    "Stawberry",
    "Banana Smoothies",
    "Croissant",
    "Cookie",
    "Chocolate Cake",
    "Cheesecake",
    "Chocolate Brownies",
  ];

  final recentMenu = [
    "Espresso",
    "Affogato",
    "Chocolate Cold",
    "Stawberry",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          color: Color(0xff623B28),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          color: Color(0xff623B28),
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return GestureDetector(
      onTap: () {},
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentMenu
        : menu.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                  color: Color(0xff623B28),
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
