/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycoffe/menuData/product.dart';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "product";
  
  Future<List<Product>> getProduct() =>
    _firestore.collection(collection).where("name", isEqualTo: true).getDocuments().then((snap){
      List<Product> productsItem = [];
    return snap.document.map((snapshot) => productsItem.add(Product.fromSnapShot(snapshot)));
    return productsItem;
  });
    
}*/