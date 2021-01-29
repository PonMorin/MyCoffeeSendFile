import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice.dart';

class MilkChocolate{
  String image;
  String name;
  int    price;

  MilkChocolate(this.image,this.name,this.price);

  MilkChocolate.fromMap(Map<String, dynamic> map){
    image = map["image"];
    name = map["name"];
    price = map["price"];
  }
  
  

  
}