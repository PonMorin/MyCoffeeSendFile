import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../choice.dart';

class OnlineModel{
  int    Total;

  OnlineModel(this.Total);

  // AllCoffee.fromMap(Map<String, dynamic> map){
  //   image = map["image"];
  //   name = map["name"];
  //   price = map["price"];
  // }
  
OnlineModel.fromJson(Map<String, dynamic> json)
      : Total = json["Total"];
        
  Map<String, dynamic> toJson() => {'Total': Total,};
}