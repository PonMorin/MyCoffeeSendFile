import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'choice.dart';

class CloudFirestoreSearch extends StatefulWidget {
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff623B28)),
          //automaticallyImplyLeading: false,
          backgroundColor: Color(0xffEED9B9),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Color(0xff623B28),), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? FirebaseFirestore.instance
                .collection('search')
                .where("searchKey", arrayContains: name)
                .snapshots()
            : FirebaseFirestore.instance.collection("recent").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
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
                                                          menuImg: data["image"],
                                                          foodName: data["productName"],
                                                          foodPrice: data["price"],
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
                                                    data["productName"],
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
                                                    "${data["price"]}",
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
                                                            data["image"])))),
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
                  },
                );
        },
      ),
    );
  }

}
