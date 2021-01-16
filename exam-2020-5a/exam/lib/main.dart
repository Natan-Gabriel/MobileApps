import 'package:flutter/material.dart';
import 'ListAircraft.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planes App',
      theme: ThemeData(         
        primaryColor: Colors.green,
      ),                       
      home: ListAircraft(),
    );
  }
}
