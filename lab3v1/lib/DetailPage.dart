import 'package:flutter/material.dart';
import 'Aircraft.dart';
import 'DetailWidget.dart';

class DetailPage extends StatefulWidget {

  final Aircraft _aircraft;

  DetailPage(this._aircraft);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._aircraft.tailNumber) , 
        
        // toolbarHeight: 200,
        
        
      ),
      body: DetailWidget(widget._aircraft),
    );
  }
}