import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice.dart';

class Recommend{
  String image;
  String name;
  int    price;

  Recommend(this.image,this.name,this.price);

  
Recommend.fromJson(Map<String, dynamic> json)
      : image = json["image"],
        name = json['name'],
        price = json["price"];  
  Map<String, dynamic> toJson() => {'image': image, 'name': name, 'price': price};
}