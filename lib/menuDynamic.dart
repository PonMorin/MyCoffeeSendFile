import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycoffe/ProductModel/recommend.dart';
import 'package:mycoffe/dataProduct.dart';
import 'choice.dart';
import 'package:mycoffe/choice.dart';
import 'cart.dart';
import 'package:mycoffe/Login2.dart';
import 'package:flutter_cart/flutter_cart.dart';

class MenuDynamic extends StatefulWidget {
  final User user;

  const MenuDynamic({Key key, this.user}) : super(key: key);
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenuDynamic> {
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
                height: 12.0,
              ),
            
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
        body: Stack(
          children: <Widget>[
              
             StreamBuilder<QuerySnapshot>(
                    stream: firebaseFirestore.collection("coffee").snapshots(),
                    builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      if (querySnapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                        ));
                      } else {
                        final list = querySnapshot.data.docs;
                        return new ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {

                            String img = list[index]['image'];
                            String foodName = list[index]['name'];
                            int price = list[index]['price'];

                            return Column(
                              children: [
                                
                                Padding(
                                padding: EdgeInsets.all(16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ChoiceScreen(
                                                  menuImg: img,
                                                  foodName: foodName,
                                                  foodPrice: price,
                                                )));
                                  },
                                  child: Row(
                                    children: <Widget>[
                                    
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                image: NetworkImage(img)))),
                                  ]),
                                ))
                              ],
                            );              
                          },
                        );
                      }
                    }),

                
/*
               StreamBuilder<QuerySnapshot>(
                    stream: firebaseFirestore.collection("Tea").snapshots(),
                    builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      if (querySnapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                        ));
                      } else {
                        final list = querySnapshot.data.docs;
                        return new ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {

                            String img = list[index]['image'];
                            String foodName = list[index]['name'];
                            int price = list[index]['price'];

                            return Column(
                              children: [
                                
                                Padding(
                                padding: EdgeInsets.all(16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ChoiceScreen(
                                                  menuImg: img,
                                                  foodName: foodName,
                                                  foodPrice: price,
                                                )));
                                  },
                                  child: Row(
                                    children: <Widget>[
                                    
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                image: NetworkImage(img)))),
                                  ]),
                                ))
                              ],
                            );              
                          },
                        );
                      }
                    }),*/
              

          ],
        ));
  }


  Widget _getSmallItem() {
    return GetBuilder<DataController>(
      init: DataController(),
      builder: (value) {
        return new FutureBuilder(
          future: value.getData("coffee"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ));
            } else {
              return new ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {

                  String head = snapshot.data[index].data()['Head'];
                  String img = snapshot.data[index].data()['image'];
                  String foodName = snapshot.data[index].data()['name'];
                  int price = snapshot.data[index].data()['price'];

                  return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChoiceScreen(
                                    menuImg: img,
                                    foodName: foodName,
                                    foodPrice: price,
                                  )));
                        },
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      image: NetworkImage(img)))),
                        ]),
                      ));
                },
              );
            }
          },
        );
      },
    );
  }



  Widget _getOther() {
    return StreamBuilder<QuerySnapshot>(
                    stream: firebaseFirestore.collection("coffee").snapshots(),
                    builder: (BuildContext contex,
                        AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      if (querySnapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ));
                      } else {
                        final list = querySnapshot.data.docs;
                        return new ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            String img = list[index]['image'];
                            String foodName = list[index]['name'];
                            int price = list[index]['price'];

                            return Padding(
                                padding: EdgeInsets.all(16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ChoiceScreen(
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
                                            MainAxisAlignment.spaceBetween,
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
                                                image: NetworkImage(img)))),
                                  ]),
                                ));
                          },
                        );
                      }
                    }
    );
  }


  Widget foodCard(String img, String nameFood, int price) {
    return Container(
        child: Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChoiceScreen(
                        menuImg: img,
                        foodName: nameFood,
                        foodPrice: price,
                      )));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  img,
                  height: 80.0,
                  width: 120,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Flexible(
                  child: Text(
                    nameFood,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff623B28)),
                  ),
                ),
                SizedBox(
                  height: 1.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${price}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    /*Expanded(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        color: Color(0xff623B28),
                      ),
                    ),
                  )*/
                  ],
                )
              ],
            ),
          )),
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
