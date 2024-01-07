import 'package:flutter/material.dart';
import 'package:flutter_api_tut/screen/example2.dart';
import 'package:flutter_api_tut/screen/example_three.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExampleThree(),
    );
  }
}
