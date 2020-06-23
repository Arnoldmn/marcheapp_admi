import 'package:flutter/material.dart';
import 'package:marcheappadmi/providers/app_state.dart';
import 'package:marcheappadmi/providers/product_provider.dart';
import 'package:marcheappadmi/screens/admin.dart';
import 'package:marcheappadmi/screens/dashboard.dart';
import 'package:provider/provider.dart';

main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppState()),
        ChangeNotifierProvider.value(value: ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Dashboard(),
      ),
    ),
  );
}
