import 'package:flutter/material.dart';
import 'package:marcheappadmi/screens/admin.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrange.shade900,
      ),
      home: AdminPanel(),
    ),
  );
}

