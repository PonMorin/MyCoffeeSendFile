import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  static const NAME = "name";
  static const PRICE = "price";
  static const IMAGE = "image";

  String _name;
  int _price;
  String _img;

  String get name => _name;
  int get price => _price;
  String get img => _img;
  

  Product.fromSnapShot(DocumentSnapshot snapshot){
    Map data = snapshot.data();
    _name = data[NAME];
    _price = data[PRICE];
    _img = data[IMAGE];
  }
}