import 'package:flutter/material.dart';
import 'package:flutter_application_4/map2.dart';
import 'map3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Map3(),
      debugShowCheckedModeBanner: false,
    );
  }
  }