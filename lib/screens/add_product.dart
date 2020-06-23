import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marcheappadmi/db/product.dart';
import 'package:marcheappadmi/providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../db/category.dart';
import '../db/brand.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService categoryService = CategoryService();
  BrandService brandService = BrandService();
  ProductService productService = ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  File _fileImage1;

  bool isLoading = false;

  Color white = Colors.white;
  Color deepOrange = Colors.deepOrange;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  List<String> selectedSizes = <String>[];
  List<String> colors = <String>[];
  bool onSale = false;
  bool featured = false;

  String _currentCategory;
  String _currentBrand;

  @override
  void initState() {
    _getCategories();
    _getBrands();
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
          0,
          DropdownMenuItem(
            child: Text(categories[i]['category']),
            value: categories[i].data['category'],
          ),
        );
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandsDropdown() {
    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < brands.length; i++) {
      setState(
        () {
          items.insert(
            0,
            DropdownMenuItem(
              child: Text(brands[i]['brand']),
              value: brands[i].data['brand'],
            ),
          );
        },
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
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
        child: SingleChildScrollView(
          child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlineButton(
                                borderSide: BorderSide(
                                  color: grey.withOpacity(0.5),
                                  width: 2.5,
                                ),
                                onPressed: () {
                                  _selectImage(
                                      ImagePicker.pickImage(
                                          source: ImageSource.gallery),
                                      1);
                                },
                                child: _displayChild1(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Enter a product name with 10 characters maximum',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: deepOrange,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Text(
                        'Available colors',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                if (productProvider.selectedColors
                                    .contains('red')) {
                                  productProvider.removeColor('red');
                                } else {
                                  productProvider.addColors('red');
                                }
                                setState(() {
                                  colors = productProvider.selectedColors;
                                });
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                    color: productProvider.selectedColors
                                            .contains('red')
                                        ? Colors.blue
                                        : grey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                if (productProvider.selectedColors
                                    .contains('yellow')) {
                                  productProvider.removeColor('yellow');
                                } else {
                                  productProvider.addColors('yellow');
                                }
                                setState(() {
                                  colors = productProvider.selectedColors;
                                });
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                    color: productProvider.selectedColors
                                            .contains('yellow')
                                        ? red
                                        : grey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.yellow,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                if (productProvider.selectedColors
                                    .contains('blue')) {
                                  productProvider.removeColor('blue');
                                } else {
                                  productProvider.addColors('blue');
                                }
                                setState(() {
                                  colors = productProvider.selectedColors;
                                });
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                    color: productProvider.selectedColors
                                            .contains('blue')
                                        ? red
                                        : grey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                if (productProvider.selectedColors
                                    .contains('green')) {
                                  productProvider.removeColor('green');
                                } else {
                                  productProvider.addColors('green');
                                }
                                setState(() {
                                  colors = productProvider.selectedColors;
                                });
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                    color: productProvider.selectedColors
                                            .contains('green')
                                        ? red
                                        : grey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                if (productProvider.selectedColors
                                    .contains('white')) {
                                  productProvider.removeColor('white');
                                } else {
                                  productProvider.addColors('white');
                                }
                                setState(() {
                                  colors = productProvider.selectedColors;
                                });
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                    color: productProvider.selectedColors
                                            .contains('white')
                                        ? red
                                        : grey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                if (productProvider.selectedColors
                                    .contains('black')) {
                                  productProvider.removeColor('black');
                                } else {
                                  productProvider.addColors('black');
                                }
                                setState(() {
                                  colors = productProvider.selectedColors;
                                });
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                    color: productProvider.selectedColors
                                            .contains('black')
                                        ? red
                                        : grey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                    backgroundColor: black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text("Available sizes"),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: selectedSizes.contains('XS'),
                            onChanged: (value) => changeSelectedSize('XS'),
                          ),
                          Text('XS'),
                          Checkbox(
                            value: selectedSizes.contains('S'),
                            onChanged: (value) => changeSelectedSize('S'),
                          ),
                          Text('S'),
                          Checkbox(
                            value: selectedSizes.contains('M'),
                            onChanged: (value) => changeSelectedSize('M'),
                          ),
                          Text('M'),
                          Checkbox(
                            value: selectedSizes.contains('L'),
                            onChanged: (value) => changeSelectedSize('L'),
                          ),
                          Text('L'),
                          Checkbox(
                            value: selectedSizes.contains('XL'),
                            onChanged: (value) => changeSelectedSize('XL'),
                          ),
                          Text('XL'),
                          Checkbox(
                            value: selectedSizes.contains('XXL'),
                            onChanged: (value) => changeSelectedSize('XXL'),
                          ),
                          Text('XXL'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: selectedSizes.contains('28'),
                            onChanged: (value) => changeSelectedSize('28'),
                          ),
                          Text('28'),
                          Checkbox(
                            value: selectedSizes.contains('30'),
                            onChanged: (value) => changeSelectedSize('30'),
                          ),
                          Text('30'),
                          Checkbox(
                            value: selectedSizes.contains('32'),
                            onChanged: (value) => changeSelectedSize('32'),
                          ),
                          Text('32'),
                          Checkbox(
                            value: selectedSizes.contains('34'),
                            onChanged: (value) => changeSelectedSize('34'),
                          ),
                          Text('34'),
                          Checkbox(
                            value: selectedSizes.contains('36'),
                            onChanged: (value) => changeSelectedSize('36'),
                          ),
                          Text('36'),
                          Checkbox(
                            value: selectedSizes.contains('38'),
                            onChanged: (value) => changeSelectedSize('38'),
                          ),
                          Text('38'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: selectedSizes.contains('40'),
                            onChanged: (value) => changeSelectedSize('40'),
                          ),
                          Text('40'),
                          Checkbox(
                            value: selectedSizes.contains('42'),
                            onChanged: (value) => changeSelectedSize('42'),
                          ),
                          Text('42'),
                          Checkbox(
                            value: selectedSizes.contains('44'),
                            onChanged: (value) => changeSelectedSize('44'),
                          ),
                          Text('44'),
                          Checkbox(
                            value: selectedSizes.contains('46'),
                            onChanged: (value) => changeSelectedSize('46'),
                          ),
                          Text('46'),
                          Checkbox(
                            value: selectedSizes.contains('48'),
                            onChanged: (value) => changeSelectedSize('48'),
                          ),
                          Text('48'),
                          Checkbox(
                            value: selectedSizes.contains('50'),
                            onChanged: (value) => changeSelectedSize('50'),
                          ),
                          Text('50'),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _productNameController,
                          decoration: InputDecoration(
                            labelText: 'Product name',
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'You must enter product name';
                              // ignore: missing_return
                            } else if (value.length > 10) {
                              return 'Product name can not have more than 10 letters';
                            }
                          },
                        ),
                      ),

                      /** SELECT CATEGORY & BRAND **/
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Category: ',
                              style: TextStyle(color: deepOrange),
                            ),
                          ),
                          DropdownButton(
                            items: categoriesDropDown,
                            onChanged: changeSelectedCategory,
                            value: _currentCategory,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Brand: ',
                              style: TextStyle(color: deepOrange),
                            ),
                          ),
                          DropdownButton(
                            items: brandsDropDown,
                            onChanged: changeSelectedBrand,
                            value: _currentBrand,
                          ),
                        ],
                      ),
                      /** END SELECT CATEGORY & BRAND **/

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Quantity',
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'You must enter product quantity';
                              // ignore: missing_return
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Price',
                          ),
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'You must enter product price';
                              // ignore: missing_return
                            }
                          },
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          validateAndUpload();
                        },
                        color: deepOrange,
                        child: Text(
                          "Add product",
                          style: TextStyle(color: white),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await categoryService.categoriesList();
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropdown();
      _currentCategory = categories[0].data['category'];
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await brandService.brandsList();
    setState(() {
      brands = data;
      brandsDropDown = getBrandsDropdown();
      _currentBrand = brands[0].data['brand'];
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentCategory = selectedBrand);
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;

    setState(() => _fileImage1 = tempImg);
  }

  Widget _displayChild1() {
    if (_fileImage1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 70.0, 14.0, 70.0),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _fileImage1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      if (_fileImage1 != null) {
        if (selectedSizes.isNotEmpty) {
          String imageUrl1;

          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1 =
              storage.ref().child(picture1).putFile(_fileImage1);

          StorageTaskSnapshot snapshot1 =
              await task1.onComplete.then((snapshot) => snapshot);

          task1.onComplete.then((snapshot3) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();

            productService.uploadProduct({
              "name": _productNameController.text,
              "price": double.parse(_priceController.text),
              "sizes": selectedSizes,
              "colors": colors,
              "picture": imageUrl1,
              "quantity": int.parse(_quantityController.text),
              "brand": _currentBrand,
              "category": _currentCategory,
              'sale': onSale,
              'featured': featured
            });
            _formKey.currentState.reset();
            setState(() => isLoading = false);
            Navigator.pop(context);
          });
        } else {
          setState(() => isLoading = false);
        }
      } else {
        setState(() => isLoading = false);

//        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }
}
