import 'package:flutter/material.dart';
import 'package:basic/pertemuan14/pertemuan14_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Pertemuan14Screen(),
    );
  }
}
