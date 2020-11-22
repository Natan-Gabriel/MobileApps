
import 'package:flutter/material.dart';
import 'Aircraft.dart';
import 'UpdateWidget.dart';


class UpdatePage extends StatefulWidget {

  final Aircraft _aircraft;

  UpdatePage(this._aircraft);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update an aircraft'),
      ),
      body: UpdateWidget(widget._aircraft),
    );
  }
}