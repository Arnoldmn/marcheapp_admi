import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  static const String BRAND = "brand";
  static const String CATEGORY = "categories";
  static const String COLORS = "colors";
  static const String FEATURED = "featured";
  static const String ID = "id";
  static const String NAME = "name";
  static const String PICTURE = "picture";
  static const String PRICE = "price";
  static const String QUANTITY = "quantity";
  static const String SALE = "sale";
  static const String SIZE = "size";

  String _brand;
  String _category;
  String _id;
  String _name;
  String _picture;
  double _price;
  int _quantity;
  List<String> _colors;
  List<String> _size;
  bool _featured;
  double _sale;

  String get brand => _brand;

  String get category => _category;

  String get id => _id;

  String get name => _name;

  String get picture => _picture;

  double get price => _price;

  int get quantity => _quantity;

  List<String> get colors => _colors;

  List<String> get size => _size;

  bool get featured => _featured;

  double get sale => _sale;

  Product.fromSnapShot(DocumentSnapshot snapshot) {
    _brand = snapshot.data[BRAND];
    _category = snapshot.data[CATEGORY];
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _picture = snapshot.data[PICTURE];
    _price = snapshot.data[PRICE];
    _quantity = snapshot.data[QUANTITY];
    _colors = snapshot.data[COLORS];
    _size = snapshot.data[SIZE];
    _featured = snapshot.data[FEATURED];
    _sale = snapshot.data[SALE];
  }
}
