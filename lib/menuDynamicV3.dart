// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mycoffe/ProductModel/bakery.dart';
// import 'package:mycoffe/ProductModel/coffee.dart';
// import 'package:mycoffe/ProductModel/coffeeV2.dart';
// import 'package:mycoffe/ProductModel/milkChocolate.dart';
// import 'package:mycoffe/ProductModel/recommend.dart';
// import 'package:mycoffe/ProductModel/tea.dart';
// import 'package:mycoffe/ProductModel/topic.dart';
// import 'choice.dart';
// import 'package:mycoffe/choice.dart';
// import 'cart.dart';
// import 'package:mycoffe/Login2.dart';
// import 'package:flutter_cart/flutter_cart.dart';
// import 'ProductModel/coffee.dart';

// class MenuDynamic3 extends StatefulWidget {
//   final User user;

//   const MenuDynamic3({Key key, this.user}) : super(key: key);
//   @override
//   _MenuDynamic3State createState() => _MenuDynamic3State();
// }

// class _MenuDynamic3State extends State<MenuDynamic3> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//   var comment;

//   final allComment = new TextEditingController();

//   var cart = FlutterCart();

//  //Product length//
//   List<Topic> topics = List();
//   List<Recommend> recommend = List();
//   List<AllCoffee2> menus = List();
//   List<Tea> menuTea = List();
//   List<MilkChocolate> menuMilk = List();
//   List<Bakery> menuBakery = List();

//   @override
//   void initState() {
//     super.initState();
//     readAllData();
//     readAllData2();
//     readAllData3();
//     readAllData4();
//     readAllData5();
//   }

//   Future<void> readAllData() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     CollectionReference collectionReference =
//         firestore.collection("RecommendV2");
//     await collectionReference.snapshots().listen((response) {
//       List<DocumentSnapshot> snapshots = response.docs;
//       for (var snapshot in snapshots) {
//         Recommend menuRecommend = Recommend.fromMap(snapshot.data());
//         setState(() {
//           recommend.add(menuRecommend);
//         });
//       }
//     });
//   }

//   Future<void> readAllData2() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     CollectionReference collectionReference = firestore.collection("coffee");
//     await collectionReference.snapshots().listen((response) {
//       List<DocumentSnapshot> snapshots = response.docs;
//       for (var snapshot in snapshots) {
//         AllCoffee2 menuCoffee = AllCoffee2.fromMap(snapshot.data());
//         setState(() {
//           menus.add(menuCoffee);
//         });
//       }
//     });
//   }

//   Future<void> readAllData3() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     CollectionReference collectionReference = firestore.collection("Tea");
//     await collectionReference.snapshots().listen((response) {
//       List<DocumentSnapshot> snapshots = response.docs;
//       for (var snapshot in snapshots) {
//         Tea teatea = Tea.fromMap(snapshot.data());
//         setState(() {
//           menuTea.add(teatea);
//         });
//       }
//     });
//   }

//   Future<void> readAllData4() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     CollectionReference collectionReference = firestore.collection("milk");
//     await collectionReference.snapshots().listen((response) {
//       List<DocumentSnapshot> snapshots = response.docs;
//       for (var snapshot in snapshots) {
//         MilkChocolate milkmilk = MilkChocolate.fromMap(snapshot.data());
//         setState(() {
//           menuMilk.add(milkmilk);
//         });
//       }
//     });
//   }

//   Future<void> readAllData5() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     CollectionReference collectionReference = firestore.collection("bakery");
//     await collectionReference.snapshots().listen((response) {
//       List<DocumentSnapshot> snapshots = response.docs;
//       for (var snapshot in snapshots) {
//         Bakery bakerybakery = Bakery.fromMap(snapshot.data());
//         setState(() {
//           menuBakery.add(bakerybakery);
//         });
//       }
//     });
//   }

//   // Product Length//

//   Future<void> everyComment(BuildContext context) async{
//     return await showDialog(context: context,
//       builder: (context){
//         return AlertDialog(
//           content: Form(child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: allComment,
//                 validator: (value){
//                   return value.isNotEmpty ? null : "Invalid Field";
//                 },
//                 decoration: InputDecoration(hintText: "Comment"),
//               )
//             ],
//           ),),
//           actions: [
//             TextButton(
//                child: Text("Send",style: TextStyle(
//                 fontFamily: "Roboto",
//                 color: Color(0xff623B28),
//               ),),
//               onPressed: () async{
//                 if(allComment.text.isNotEmpty){
//                  await FirebaseFirestore.instance.collection('comment').add({
//                 'comment': allComment.text,
//              });
//                 Navigator.of(context).pop();
//                 allComment.clear();
//                 }
//               }, 
//             )
//           ],
//         );
//       }
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _scaffoldKey,
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           iconTheme: IconThemeData(color: Color(0xff623B28)),
//           //automaticallyImplyLeading: false,
//           backgroundColor: Color(0xffEED9B9),
//           centerTitle: true,
//           title: Text('MyCoffee',
//               style: TextStyle(
//                 fontFamily: "Roboto",
//                 color: Color(0xff623B28),
//               )),
//           actions: <Widget>[
//             Padding(
//                 padding: EdgeInsets.only(right: 5.0),
//                 child: IconButton(
//                     icon: Icon(Icons.search),
//                     color: Color(0xff623B28),
//                     onPressed: () {
//                       showSearch(context: context, delegate: DataSearch());
//                     }))
//           ],
//         ),
//         drawer: Drawer(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(20.0),
//                 color: Color(0xffEED9B9),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         "user: ${widget.user.displayName}",
//                         style: TextStyle(
//                             color: Color(0xff623B28),
//                             fontFamily: "Roboto",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20.0),
//                       ),
//                       SizedBox(height: 5.0),
//                       Text(
//                         "email: ${widget.user.email}",
//                         style: TextStyle(
//                             color: Color(0xff623B28),
//                             fontFamily: "Roboto",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15.0),
//                       ),
//                     ]),
//               ),
//               SizedBox(
//                 height: 14.0,
//               ),
//               GestureDetector(
//                   child: ListTile(
//                       onTap: () async {
//                         everyComment(context);
//                       },
//                       leading: Icon(Icons.comment),
//                       title: Text(
//                         "Comment",
//                         style: TextStyle(
//                             color: Color(0xff623B28),
//                             fontFamily: "Roboto",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15.0),
//                       ))),
//               SizedBox(
//                 height: 2.0,
//               ),
//               GestureDetector(
//                   child: ListTile(
//                       onTap: () async {
//                         _signOut().whenComplete(() {
//                           Navigator.of(context)
//                               .pushReplacement(MaterialPageRoute(builder: (_) {
//                             return LoginPage2();
//                           }));
//                         });
//                       },
//                       leading: Icon(Icons.logout),
//                       title: Text(
//                         "Logout",
//                         style: TextStyle(
//                             color: Color(0xff623B28),
//                             fontFamily: "Roboto",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15.0),
//                       ))),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0.0, 260, 0.0, 0.0),
//                 child: Center(
//                   child: Container(
//                       height: 210.0,
//                       child: Image.asset("images/drinkCoffee.jpg")),
//                 ),
//               )
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           //color: Color(0xffEED9B9),
//           child: Container(
//             height: 65.0,
//             child: RaisedButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AllCart()),
//                 );
//               },
//               color: Color(0xffEED9B9),
//               icon: Icon(
//                 Icons.shopping_cart,
//                 size: 35,
//                 color: Color(0xff623B28),
//               ),
//               label: Text("Cart",
//                   style: TextStyle(
//                     color: Color(0xff623B28),
//                     fontSize: 35,
//                   )),
//             ),
//           ),
//         ),
//         body: SafeArea(
//           child: Stack(children: <Widget>[
//             CustomScrollView(
//               slivers: <Widget>[
//                 Container(
//                   child: SliverList(
//                       delegate: SliverChildListDelegate([
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(15.0, 8.0, 0.0, 0.0),
//                       child: Text(
//                         "Recommend For You",
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Color(0xff623B28),
//                           fontFamily: "RobotoMono",
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ])),
//                 ),
//                 Container(
//                   child: SliverGrid(
//                       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                           maxCrossAxisExtent: 200,
//                           childAspectRatio: 3 / 2,
//                           crossAxisSpacing: 5,
//                           mainAxisSpacing: 5),
//                       delegate: SliverChildBuilderDelegate(
//                           (BuildContext context, int index) {
//                         return StreamBuilder<QuerySnapshot>(
//                             stream: firebaseFirestore
//                                 .collection("RecommendV2")
//                                 .snapshots(),
//                             builder: (BuildContext context,
//                                 AsyncSnapshot<QuerySnapshot> querySnapshot) {
//                               if (querySnapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Center(
//                                     child: CircularProgressIndicator(
//                                   backgroundColor: Colors.white,
//                                 ));
//                               } else {
//                                 final list = querySnapshot.data.docs;
//                                 String img = list[index]['image'];
//                                 String foodName = list[index]['name'];
//                                 int price = list[index]['price'];
//                                 return Center(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: GestureDetector(
//                                             onTap: () {
//                                               Navigator.of(context).push(
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           ChoiceScreen(
//                                                             menuImg: img,
//                                                             foodName: foodName,
//                                                             foodPrice: price,
//                                                           )));
//                                             },
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Image.network(
//                                                   img,
//                                                   height: 60.0,
//                                                   width: 120,
//                                                 ),
//                                                 Text(
//                                                   foodName,
//                                                   style: TextStyle(
//                                                       fontSize: 15.0,
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: Color(0xff623B28)),
//                                                 ),
//                                                 Text(
//                                                   "${price}",
//                                                   style: TextStyle(
//                                                     color: Colors.grey,
//                                                     fontSize: 13.0,
//                                                     fontWeight: FontWeight.w700,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ))
//                                     ],
//                                   ),
//                                 );
//                               }
//                             });
//                       }, childCount: recommend.length)),
//                 ),
//                 Container(
//                   child: SliverList(
//                       delegate: SliverChildListDelegate([
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
//                       child: Text(
//                         "Coffee",
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Color(0xff623B28),
//                           fontFamily: "RobotoMono",
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ])),
//                 ),
//                 Container(
//                   child: SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                       (BuildContext context, int index) {
//                         return StreamBuilder<QuerySnapshot>(
//                             stream: firebaseFirestore
//                                 .collection("coffee")
//                                 .snapshots(),
//                             builder: (BuildContext context,
//                                 AsyncSnapshot<QuerySnapshot> querySnapshot) {
//                               if (querySnapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Center(
//                                     child: CircularProgressIndicator(
//                                   backgroundColor: Colors.white,
//                                 ));
//                               } else {
//                                 final list = querySnapshot.data.docs;
//                                 String img = list[index]['image'];
//                                 String foodName = list[index]['name'];
//                                 int price = list[index]['price'];

//                                 return Column(
//                                   children: [
//                                     Padding(
//                                         padding: EdgeInsets.all(16.0),
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             Navigator.of(context).push(
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         ChoiceScreen(
//                                                           menuImg: img,
//                                                           foodName: foodName,
//                                                           foodPrice: price,
//                                                         )));
//                                           },
//                                           child: Row(children: <Widget>[
//                                             Expanded(
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.stretch,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: <Widget>[
//                                                   Text(
//                                                     foodName,
//                                                     style: TextStyle(
//                                                       fontFamily: "Roboto",
//                                                       fontSize: 18.0,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: Color(0xff623B28),
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 5.0),
//                                                   Text(
//                                                     "${price}",
//                                                     style: TextStyle(
//                                                       fontSize: 15.0,
//                                                       fontFamily: "Roboto",
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: Colors.grey,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Container(
//                                                 width: 70.0,
//                                                 height: 70.0,
//                                                 decoration: BoxDecoration(
//                                                     image: DecorationImage(
//                                                         image: NetworkImage(
//                                                             img)))),
//                                           ]),
//                                         )),
//                                     Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 10.0),
//                                       child: Container(
//                                           height: 1.0,
//                                           width: 600.0,
//                                           color: Colors.grey[400]),
//                                     ),
//                                   ],
//                                 );
//                               }
//                             });
//                       },
//                       childCount: menus.length,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: SliverList(
//                       delegate: SliverChildListDelegate([
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
//                       child: Text(
//                         "Tea",
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Color(0xff623B28),
//                           fontFamily: "RobotoMono",
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ])),
//                 ),
//                 Container(
//                   child: SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                         (BuildContext context, int index) {
//                       return StreamBuilder<QuerySnapshot>(
//                           stream:
//                               firebaseFirestore.collection("Tea").snapshots(),
//                           builder: (BuildContext context,
//                               AsyncSnapshot<QuerySnapshot> querySnapshot) {
//                             if (querySnapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Center(
//                                   child: CircularProgressIndicator(
//                                 backgroundColor: Colors.white,
//                               ));
//                             } else {
//                               final list = querySnapshot.data.docs;
//                               String img = list[index]['image'];
//                               String foodName = list[index]['name'];
//                               int price = list[index]['price'];

//                               return Column(
//                                 children: [
//                                   Padding(
//                                       padding: EdgeInsets.all(16.0),
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           Navigator.of(context).push(
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       ChoiceScreen(
//                                                         menuImg: img,
//                                                         foodName: foodName,
//                                                         foodPrice: price,
//                                                       )));
//                                         },
//                                         child: Row(children: <Widget>[
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.stretch,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: <Widget>[
//                                                 Text(
//                                                   foodName,
//                                                   style: TextStyle(
//                                                     fontFamily: "Roboto",
//                                                     fontSize: 18.0,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Color(0xff623B28),
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 5.0),
//                                                 Text(
//                                                   "${price}",
//                                                   style: TextStyle(
//                                                     fontSize: 15.0,
//                                                     fontFamily: "Roboto",
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.grey,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                               width: 70.0,
//                                               height: 70.0,
//                                               decoration: BoxDecoration(
//                                                   image: DecorationImage(
//                                                       image:
//                                                           NetworkImage(img)))),
//                                         ]),
//                                       )),
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 10.0),
//                                     child: Container(
//                                         height: 1.0,
//                                         width: 600.0,
//                                         color: Colors.grey[400]),
//                                   ),
//                                 ],
//                               );
//                             }
//                           });
//                     }, childCount: menuTea.length),
//                   ),
//                 ),
//                 Container(
//                   child: SliverList(
//                       delegate: SliverChildListDelegate([
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
//                       child: Text(
//                         "Milk & Chocolate",
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Color(0xff623B28),
//                           fontFamily: "RobotoMono",
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ])),
//                 ),
//                 Container(
//                   child: SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                         (BuildContext context, int index) {
//                       return StreamBuilder<QuerySnapshot>(
//                           stream:
//                               firebaseFirestore.collection("milk").snapshots(),
//                           builder: (BuildContext context,
//                               AsyncSnapshot<QuerySnapshot> querySnapshot) {
//                             if (querySnapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Center(
//                                   child: CircularProgressIndicator(
//                                 backgroundColor: Colors.white,
//                               ));
//                             } else {
//                               final list = querySnapshot.data.docs;
//                               String img = list[index]['image'];
//                               String foodName = list[index]['name'];
//                               int price = list[index]['price'];

//                               return Column(
//                                 children: [
//                                   Padding(
//                                       padding: EdgeInsets.all(16.0),
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           Navigator.of(context).push(
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       ChoiceScreen(
//                                                         menuImg: img,
//                                                         foodName: foodName,
//                                                         foodPrice: price,
//                                                       )));
//                                         },
//                                         child: Row(children: <Widget>[
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.stretch,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: <Widget>[
//                                                 Text(
//                                                   foodName,
//                                                   style: TextStyle(
//                                                     fontFamily: "Roboto",
//                                                     fontSize: 18.0,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Color(0xff623B28),
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 5.0),
//                                                 Text(
//                                                   "${price}",
//                                                   style: TextStyle(
//                                                     fontSize: 15.0,
//                                                     fontFamily: "Roboto",
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.grey,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                               width: 70.0,
//                                               height: 70.0,
//                                               decoration: BoxDecoration(
//                                                   image: DecorationImage(
//                                                       image:
//                                                           NetworkImage(img)))),
//                                         ]),
//                                       )),
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 10.0),
//                                     child: Container(
//                                         height: 1.0,
//                                         width: 600.0,
//                                         color: Colors.grey[400]),
//                                   ),
//                                 ],
//                               );
//                             }
//                           });
//                     }, childCount: menuMilk.length),
//                   ),
//                 ),
//                 Container(
//                   child: SliverList(
//                       delegate: SliverChildListDelegate([
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
//                       child: Text(
//                         "Bakery",
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Color(0xff623B28),
//                           fontFamily: "RobotoMono",
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ])),
//                 ),
//                 Container(
//                   child: SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                         (BuildContext context, int index) {
//                       return StreamBuilder<QuerySnapshot>(
//                           stream: firebaseFirestore
//                               .collection("bakery")
//                               .snapshots(),
//                           builder: (BuildContext context,
//                               AsyncSnapshot<QuerySnapshot> querySnapshot) {
//                             if (querySnapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Center(
//                                   child: CircularProgressIndicator(
//                                 backgroundColor: Colors.white,
//                               ));
//                             } else {
//                               final list = querySnapshot.data.docs;
//                               String img = list[index]['image'];
//                               String foodName = list[index]['name'];
//                               int price = list[index]['price'];

//                               return Column(
//                                 children: [
//                                   Padding(
//                                       padding: EdgeInsets.all(16.0),
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           Navigator.of(context).push(
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       ChoiceScreen(
//                                                         menuImg: img,
//                                                         foodName: foodName,
//                                                         foodPrice: price,
//                                                       )));
//                                         },
//                                         child: Row(children: <Widget>[
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.stretch,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: <Widget>[
//                                                 Text(
//                                                   foodName,
//                                                   style: TextStyle(
//                                                     fontFamily: "Roboto",
//                                                     fontSize: 18.0,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Color(0xff623B28),
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 5.0),
//                                                 Text(
//                                                   "${price}",
//                                                   style: TextStyle(
//                                                     fontSize: 15.0,
//                                                     fontFamily: "Roboto",
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.grey,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                               width: 70.0,
//                                               height: 70.0,
//                                               decoration: BoxDecoration(
//                                                   image: DecorationImage(
//                                                       image:
//                                                           NetworkImage(img)))),
//                                         ]),
//                                       )),
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 10.0),
//                                     child: Container(
//                                         height: 1.0,
//                                         width: 600.0,
//                                         color: Colors.grey[400]),
//                                   ),
//                                 ],
//                               );
//                             }
//                           });
//                     }, childCount: menuBakery.length),
//                   ),
//                 ),
                
//               ],
//             )
//           ]),
//         ));
//   }

//   Future _signOut() async {
//     await _auth.signOut();
//   }
// }

// class DataSearch extends SearchDelegate<String> {
//   final menu = [
//     "Espresso",
//     "Black coffee",
//     "Cappuccino.",
//     "Cold brew",
//     "Affogato",
//     "Green tea leamon",
//     "British tea",
//     "Rose tea",
//     "Buble tea",
//     "Milk tea",
//     "Milk Shake",
//     "Hot Dark Chocolate",
//     "Chocolate Cold",
//     "Stawberry",
//     "Banana Smoothies",
//     "Croissant",
//     "Cookie",
//     "Chocolate Cake",
//     "Cheesecake",
//     "Chocolate Brownies",
//   ];

//   final recentMenu = [
//     "Espresso",
//     "Affogato",
//     "Chocolate Cold",
//     "Stawberry",
//   ];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//           icon: Icon(Icons.clear),
//           color: Color(0xff623B28),
//           onPressed: () {
//             query = "";
//           })
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//         icon: AnimatedIcon(
//           icon: AnimatedIcons.menu_arrow,
//           color: Color(0xff623B28),
//           progress: transitionAnimation,
//         ),
//         onPressed: () {
//           close(context, null);
//         });
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestionList = query.isEmpty
//         ? recentMenu
//         : menu.where((p) => p.startsWith(query)).toList();

//     return ListView.builder(
//       itemBuilder: (context, index) => ListTile(
//         onTap: () {
//           showResults(context);
//         },
//         title: RichText(
//           text: TextSpan(
//               text: suggestionList[index].substring(0, query.length),
//               style: TextStyle(
//                   color: Color(0xff623B28),
//                   fontFamily: "Roboto",
//                   fontWeight: FontWeight.bold),
//               children: [
//                 TextSpan(
//                     text: suggestionList[index].substring(query.length),
//                     style: TextStyle(color: Colors.grey))
//               ]),
//         ),
//       ),
//       itemCount: suggestionList.length,
//     );
//   }
// }


