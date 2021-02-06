import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice.dart';

class MilkChocolate{
  String image;
  String name;
  int    price;

  MilkChocolate(this.image,this.name,this.price);

  
MilkChocolate.fromJson(Map<String, dynamic> json)
      : image = json["image"],
        name = json['name'],
        price = json["price"];  
  Map<String, dynamic> toJson() => {'image': image, 'name': name, 'price': price};
}