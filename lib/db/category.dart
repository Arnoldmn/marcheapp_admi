import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class CategoryService {
  Firestore _firestore = Firestore.instance;
  String ref = 'Categories';

  void createCategory(String name) {
    var id = new Uuid();
    String categoryId = id.v1();
    _firestore
        .collection(ref)
        .document(categoryId)
        .setData({'category': name});
  }

  Future<List<DocumentSnapshot>> getCategories() {
    return _firestore.collection(ref).getDocuments().then((snaps) {
      return snaps.documents;
    });
  }
}


