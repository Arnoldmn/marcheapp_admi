import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class BrandService {
  Firestore _firestore = Firestore.instance;
  String ref = 'Brands';

  void createBrand(String name) {
    var id = new Uuid();
    String brandId = id.v1();
    _firestore.collection(ref).document(brandId).setData({'brand': name});
  }

  Future<List<DocumentSnapshot>> getBrands() {
    return _firestore.collection(ref).getDocuments().then((snaps) {
      return snaps.documents;
    });
  }
}
