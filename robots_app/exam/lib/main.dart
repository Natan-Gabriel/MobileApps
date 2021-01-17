import 'package:flutter/material.dart';
import 'MainList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam App',
      theme: ThemeData(         
        primaryColor: Colors.green,
      ),                       
      home: MainList(),
    );
  }
}
