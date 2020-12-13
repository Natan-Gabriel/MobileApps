import 'package:flutter/material.dart';
import 'Aircraft.dart';
import 'DetailWidget.dart';

class DetailPage extends StatelessWidget {

  final Aircraft _aircraft;

  DetailPage(this._aircraft);

  @override
  Widget build(BuildContext context) {
 

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
                  
                  title: Text(_aircraft.tailNumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  
                  ),
                  backgroundColor: Colors.green,
            ),
          ];
        }, //headerSliverBuilder
        body: DetailWidget(_aircraft)
      )
    );

  }
}