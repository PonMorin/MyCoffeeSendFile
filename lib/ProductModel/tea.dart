import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice.dart';

class Tea{
  String image;
  String name;
  int    price;

  Tea(this.image,this.name,this.price);

  Tea.fromMap(Map<String, dynamic> map){
    image = map["image"];
    name = map["name"];
    price = map["price"];
  }
  
  

  
}