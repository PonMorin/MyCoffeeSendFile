import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice.dart';

class Bakery{
  String image;
  String name;
  int    price;

  Bakery(this.image,this.name,this.price);

  Bakery.fromMap(Map<String, dynamic> map){
    image = map["image"];
    name = map["name"];
    price = map["price"];
  }
  
 

  
}