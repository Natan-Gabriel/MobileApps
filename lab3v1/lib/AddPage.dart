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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Add an aircraft'),
    //   ),
    //   body: AddWidget(widget._aircrafts),
    // );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  
                  title: Text("Add an aircraft",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  
                  ),
                  backgroundColor: Colors.green,
            ),
          ];
        }, //headerSliverBuilder
        body: AddWidget(widget._aircrafts)
      )
    );




  }
}