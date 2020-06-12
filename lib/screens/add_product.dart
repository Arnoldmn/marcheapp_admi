import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../db/category.dart';
import '../db/brand.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService categoryService = CategoryService();
  BrandService brandService = BrandService();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _productNameController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];

  Color white = Colors.white;
  Color deepOraange = Colors.deepOrange;
  Color black = Colors.black;
  Color grey = Colors.grey;

  String _currentCategory;
  String _currentBrand;

  @override
  void initState() {
    _getCategories();
    categoriesDropDown = getCategoriesDropdown();
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (DocumentSnapshot category in categories) {
      items.add(new DropdownMenuItem(
        child: Text(category['category']),
        value: category['category'],
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          "Add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: deepOraange.withOpacity(0.5),
                        width: 2.5,
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(8.0, 17.0, 8.0, 17.0),
                        child: Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: deepOraange.withOpacity(0.5),
                        width: 2.5,
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(8.0, 17.0, 8.0, 17.0),
                        child: Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide: BorderSide(
                        color: deepOraange.withOpacity(0.5),
                        width: 2.5,
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(8.0, 17.0, 8.0, 17.0),
                        child: Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Enter a product name with 10 characters maximum',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: deepOraange,
                  fontSize: 14.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(hintText: 'Product name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'You must enter product name';
                  } else if (value.length > 10) {
                    return 'Product name can not have more than 10 letters';
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getCategories() async {
    List<DocumentSnapshot> data = await categoryService.getCategories();
    setState(() {
      categories = data;
    });
  }
}
