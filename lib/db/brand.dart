import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  Firestore _firestore = Firestore.instance;

  void createBrand(String name) {
    var id = new Uuid();
    String brandId = id.v1();
    _firestore
        .collection("Brands")
        .document(brandId)
        .setData({'brand': name});
  }
}