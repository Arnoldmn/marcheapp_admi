import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  Firestore _firestore = Firestore.instance;
  String ref = 'Products';

  void uploadProduct(
      {String productName,
      String brand,
      String category,
      int quantity,
      List sizes,
      List images,
      double price}) {
    var id = new Uuid();
    String productsId = id.v1();
    _firestore.collection(ref).document(productsId).setData({
      'name': productName,
      'id': productsId,
      'brand': brand,
      'category': category,
      'sizes': sizes,
      'images': images,
      'price': price
      });
  }
}
