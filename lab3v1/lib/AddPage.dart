import 'package:flutter/material.dart';
import 'Aircraft.dart';
import 'AddWidget.dart';
import 'ListAircraft.dart';

class AddPage extends StatefulWidget {


  final List<Aircraft> _aircrafts;

   AddPage(this._aircrafts);

 

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an aircraft'),
      ),
      body: AddWidget(widget._aircrafts),
    );
  }
}