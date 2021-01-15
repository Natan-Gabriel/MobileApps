

import 'package:airport_manager/ListAircraft.dart';

import 'ManageSection.dart';
import 'PlanesByManufacturer.dart';
import 'domain/Plane.dart';
import 'server/server.dart';
import 'package:airport_manager/size_config/size_config.dart';
import 'package:flutter/material.dart';
import 'Aircraft.dart';
import 'AddPage.dart';
import 'DetailPage.dart';
import 'database/database.dart';
import 'dart:developer' as developer;
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class Reports extends StatefulWidget {

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {


  bool _progressBarActive = false;
  // final Plane _aircraft;

  // _PlanesByManufacturerState(this._aircraft);

  Db db; 
  Server server;//=new Server();

  List<Plane> _manufacturers = [];  

  int selected=-1;

  List<Plane> _toAdd = [];  

  var connectivityResult;

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  @override
  void initState() {
    super.initState();
    db = Db.instance;
    server =new Server(); 

    _refreshList(context);

    connectivityResult= Connectivity().checkConnectivity();

    connectivityResult.then((data){
      connectivityResult=data;
    });
    // connectivityResult.then((val){print("val: "+val.toString());});
    
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    // Got a new connectivity status!
      print("Connectivity: " + result.toString());
      connectivityResult=result;
    });
  
  }


  _refreshList(BuildContext context) async {
    if(connectivityResult == ConnectivityResult.none){
      print("connectivityResult == ConnectivityResult.none");
      showSnackBar(context,'The server connection is down.Retry using sync button');
    }
    else{
      print("_refreshList entered");
      setProgressBar();
      List<Plane> x = await Server.getAllOrdered();
      setProgressBar();
      setState(() {
        _manufacturers = x;
      });
    }
    
  }

  void setProgressBar(){
    setState(() {
      _progressBarActive=!_progressBarActive;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold (                    
      appBar: AppBar(
        title: Text('Reports'),
        bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 1.0),
                  child: _progressBarActive == true?const LinearProgressIndicator(
                    backgroundColor: Colors.black,
                  ):new Container(),
        ),
      ),

      //body:Builder(builder: (_context) =>_buildAircrafts1(_context)),// Builder(builder: (_context) =>_buildAircrafts1(_context)),//createTable(),//_buildAircrafts(),//createTable(),  <-if you want the version from previous lab
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Builder(builder: (_context) =>ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Registration section'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     ListAircraft()
                  
                ));
              },
            ),
            ListTile(
              title: Text('Manage section'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                if(connectivityResult!=ConnectivityResult.mobile && connectivityResult!=ConnectivityResult.wifi){
                  Navigator.pop(context);
                  showSnackBar(_context, "Please connect to the internet");
                }
                else{
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     ManageSection()
                  
                ));
                }
              },
            ),
            ListTile(
              title: Text('Reports section'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      )
      ),
      
      body:_buildAircrafts1(),// Builder(builder: (_context) =>_buildAircrafts1(_context)),//createTable(),//_buildAircrafts(),//createTable(),  <-if you want the version from previous lab
      
      );                                      
  }
  

  

    Widget _buildAircrafts1(){
      return ListView.builder(
        padding: const EdgeInsets.only(top:16,left:16,right:16,bottom: 80),
        itemCount: _manufacturers.length*2,
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          print("selected: "+selected.toString());
          return _buildRow1(_manufacturers[index], _context);
        }
    );
  }

  Widget _buildRow1(Plane aircraft,BuildContext context) {

    return ListTile(
      title: Text(
        "Id: "+aircraft.id.toString()+"\n"+"Size: "+aircraft.size.toString()+"\n",
        style: _biggerFont,
      ),
      //isThreeLine: true,
      // subtitle: Text("Terminal: "+aircraft.terminal+"\n"+
      //   "Gate: "+aircraft.gate),

    //   trailing: FlatButton(
    //           onPressed: () { _showMyDialog(aircraft,context); },
    //           child: Text(
    //             "Delete",
    //           ),
    //           color: Colors.red,
    //         ),


   
      

    );
  }
    
  }

  

  void showSnackBar(BuildContext _context,String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(_context).showSnackBar(snackBar);
  }

