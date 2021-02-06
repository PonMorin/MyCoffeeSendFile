import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice.dart';

class Bakery{
 String image;
  String name;
  int    price;

  Bakery(this.image,this.name,this.price);

  
Bakery.fromJson(Map<String, dynamic> json)
      : image = json["image"],
        name = json['name'],
        price = json["price"];  
  Map<String, dynamic> toJson() => {'image': image, 'name': name, 'price': price};
}