import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice.dart';

class AllCoffee{
  String image;
  String name;
  int    price;

  AllCoffee(this.image,this.name,this.price);

  AllCoffee.fromMap(Map<String, dynamic> map){
    image = map["image"];
    name = map["name"];
    price = map["price"];
  }
  
 

  
}