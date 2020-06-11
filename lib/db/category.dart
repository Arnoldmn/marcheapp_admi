import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  Firestore _firestore = Firestore.instance;

  void createCategory(String name) {
    var id = new Uuid();
    String categoryId = id.v1();
    _firestore
        .collection("Categories")
        .document(categoryId)
        .setData({'category': name});
  }
}
