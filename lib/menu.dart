import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Owner/ownerLogin.dart';
import 'choice.dart';
import 'package:mycoffe/choice.dart';
import 'cart.dart';
import 'package:mycoffe/Login2.dart';
import 'package:flutter_cart/flutter_cart.dart';

class Menu extends StatefulWidget {
  final User user;

  const Menu({Key key, this.user}) : super(key: key);
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    
     List<String> imgFood = [
    "images/espresso.png",
    "images/black_coffe.png",
    "images/cappuccino.png",
    "images/cold-brew.png",
    "images/affogato.png",
    "images/green tea leamon.png",
    "images/Lipton-tea.jpg",
    "images/rose.jpg",
    "images/buble tea.jpg",
    "images/milk tea.png",
    "images/Milk_Shake.png",
    "images/Hot-Dark-Chocolate.png",
    "images/chocolate.png",
    "images/Stawberry cheesecake drink.png",
    "images/Banana-smoothies.png",
    "images/croissant.png",
    "images/cookie.png",
    "images/cake chocolate.png",
    "images/cheesecake.png",
    "images/chocolate-brownies.png",
  ];

  var cart = FlutterCart();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:  _scaffoldKey,
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
            }
            )
          )
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
                  Text("user: ${widget.user.displayName}",
                    style: TextStyle(
                      color: Color(0xff623B28),
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                      ),
                  ),
                  SizedBox(height: 5.0),
                  Text("email: ${widget.user.email}",
                  style: TextStyle(
                      color: Color(0xff623B28),
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                      ),
                    ),
                ]
              ),
            ),
             SizedBox(height: 12.0,),
            GestureDetector(
              child:ListTile(
              onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
                    return OwnerLogin();
                  }));
              },
              leading: Icon(Icons.person),
              title:Text("Owner",
                 style: TextStyle(
                      color: Color(0xff623B28),
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                      ),
              )
             )
            ),

             SizedBox(height: 2.0,),
            GestureDetector(
              child:ListTile(
              onTap: () async{
                _signOut().whenComplete(() {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
                    return LoginPage2();
                  }));
                });
              },
              leading: Icon(Icons.comment),
              title:Text("Comment",
                 style: TextStyle(
                      color: Color(0xff623B28),
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                      ),
              )
             )
            ),

            SizedBox(height: 2.0,),
            GestureDetector(
              child:ListTile(
              onTap: () async{
                _signOut().whenComplete(() {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_){
                    return LoginPage2();
                  }));
                });
              },
              leading: Icon(Icons.logout),
              title:Text("Logout",
                 style: TextStyle(
                      color: Color(0xff623B28),
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                      ),
              )
             )
            ),
            SizedBox(height: 330.0),
            Center(
              child: Container(
                height: 210.0,
                child: Image.asset("images/drinkCoffee.jpg")
              ),
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
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
           /* Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            offset: Offset(2, 1),
                            blurRadius: 5)
                      ]),
                  child: ListTile(
                    leading: Icon(Icons.search, color: Color(0xff623B28)),
                    title: TextField(
                      decoration: InputDecoration(
                          hintText: "Search...", border: InputBorder.none),
                    ),
                  )
                  
              ),
            ),

            SizedBox(
              height: 5,
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
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
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 1.0),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 200,
                    width: 190,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: foodCard(imgFood[0], "Espresso", 35),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  height: 200,
                  width: 190,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: foodCard(imgFood[4], "Affogato", 135),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 1.0),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 200,
                    width: 190,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: foodCard(imgFood[12], "Chocolate Cold", 35),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  height: 200,
                  width: 190,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: foodCard(imgFood[13], "Stawberry", 135),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Coffee",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff623B28),
                  fontFamily: "RobotoMono",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: _getSmallItem("Espresso",  35, imgFood[0]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Black Coffe",  45, imgFood[1]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Cappuccino",  60, imgFood[2]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Cold Brew",  65, imgFood[3]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Affogato",  135, imgFood[4]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Tea",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff623B28),
                  fontFamily: "RobotoMono",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: _getSmallItem("Leamon Tea",  50, imgFood[5]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("British Tea",  40, imgFood[6]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Rose Tea",  65, imgFood[7]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Bubble Tea",  75, imgFood[8]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Matcha Latte",  115, imgFood[9]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Milk & Chocolate",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff623B28),
                  fontFamily: "RobotoMono",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: _getSmallItem("Milk Shake",  50, imgFood[10]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Hot Dark Chocolate",  55, imgFood[11]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Chocolate Cold", 50 , imgFood[12]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Stawberry Shake", 135 , imgFood[13]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Banana Smoothies", 120 , imgFood[14]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Bakery",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff623B28),
                  fontFamily: "RobotoMono",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: _getSmallItem("Croissant", 42 , imgFood[15]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Cookie", 25, imgFood[16]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Chocolate Cake", 75, imgFood[17]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Cheese Cake", 68, imgFood[18]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
            Container(
              child: _getSmallItem("Chocolate Brownie", 40, imgFood[19]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child:
                  Container(height: 1.0, width: 130.0, color: Colors.grey[400]),
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }

  Widget _getSmallItem(String foodName, int price, String img) {
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
                  )
                ],
              ),
            ),
            Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(img)))),
          ]),
        ));
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

  Future _signOut() async{
    
    await _auth.signOut();
  }
  

}



class DataSearch extends SearchDelegate<String>  {

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
       return[
        IconButton(icon: Icon(Icons.clear),color: Color(0xff623B28), onPressed: () {
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
          }
          );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      return GestureDetector(
        
        onTap:() {
          
        },
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
    ?recentMenu
    :menu.where((p) => p.startsWith(query)).toList();

      return ListView.builder(itemBuilder: (context, index)=> ListTile(
        onTap: (){
          showResults(context);
        },
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Color(0xff623B28),fontFamily: "Roboto",fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey)
                  )
                ]
              ),
            ),
          ),
        itemCount: suggestionList.length,
      );
  }
}



  