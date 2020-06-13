import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
    _getBrands();
    getCategoriesDropdown();
//    _currentCategory = categoriesDropDown[0].value;
  }

  getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        categoriesDropDown.insert(
          0,
          DropdownMenuItem(
            child: Text(categories[i]['category']),
            value: categories[i]['category'],
          ),
        );
      });
    }
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
        child: Column(
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
            ),
            /** SELECT CATEGORY **/
            Visibility(
              visible: _currentCategory != null,
              child: InkWell(
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: deepOraange,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _currentCategory,
                          style: TextStyle(color: white),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            color: white,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentCategory = '';
                            });
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: 'Add category',
                        border: OutlineInputBorder())),
                suggestionsCallback: (pattern) async {
                  return await categoryService.getSuggestion(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.category),
                    title: Text(suggestion['category']),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  _currentCategory = suggestion;
                },
              ),
            ),
            /** SELECT BRAND **/
            Visibility(
              visible: _currentBrand != null,
              child: InkWell(
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: deepOraange,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _currentBrand,
                          style: TextStyle(color: white),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            color: white,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentBrand = '';
                            });
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Add brand',
                    border: OutlineInputBorder(),
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  return await brandService.getSuggestion(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.branding_watermark),
                    title: Text(suggestion['brand']),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  _currentBrand = suggestion;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getCategories() async {
    List<DocumentSnapshot> data = await categoryService.categoriesList();
    setState(() {
      categories = data;
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  void _getBrands() async {
    List<DocumentSnapshot> data = await brandService.brandsList();
    setState(() {
      brands = data;
    });
  }
}
