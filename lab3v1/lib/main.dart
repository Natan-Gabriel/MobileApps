import 'package:flutter/material.dart';
import 'ListAircraft.dart';
import 'Aircraft.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';

// C:\Users\Miriam\Downloads\draft_MA\lab3v1\lib\Aircraft.dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random(); // Add this line.
    return MaterialApp(
      title: 'Airport Manager',
      theme: ThemeData(          // Add the 3 lines from here... 
        primaryColor: Colors.green,
      ),                         // ... to here.
      home: RandomWords(),
    );
  }
}
