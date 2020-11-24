import 'package:flutter/material.dart';
import 'package:todoey/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeState();
  }
}