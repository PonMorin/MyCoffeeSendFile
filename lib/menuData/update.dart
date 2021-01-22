import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Update {

  updateData(docs, value){
    FirebaseFirestore.instance
        .collection('customer')
        .doc(docs)
        .update(value)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId){
    FirebaseFirestore.instance
        .collection('customer')
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}