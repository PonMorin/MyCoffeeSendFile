import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice.dart';

class Recommend{
  String image;
  String name;
  int    price;

  Recommend(this.image,this.name,this.price);

  Recommend.fromMap(Map<String, dynamic> map){
    image = map["image"];
    name = map["name"];
    price = map["price"];
  }
  
 

  
}