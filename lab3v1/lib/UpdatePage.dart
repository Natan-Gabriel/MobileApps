
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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Update an aircraft'),
    //   ),
    //   body: UpdateWidget(widget._aircraft),
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
                  
                  title: Text("Update an aircraft",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  
                  ),
                  backgroundColor: Colors.green,
            ),
          ];
        }, //headerSliverBuilder
        body: UpdateWidget(widget._aircraft)
      )
    );
  }
}