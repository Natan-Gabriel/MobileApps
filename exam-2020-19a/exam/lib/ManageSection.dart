
import 'package:airport_manager/ListAircraft.dart';
import 'package:airport_manager/Reports.dart';

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

class ManageSection extends StatefulWidget {
  @override
  _ManageSectionState createState() => _ManageSectionState();
}

class _ManageSectionState extends State<ManageSection> {

  bool _progressBarActive = false;

  Db db; 
  Server server;//=new Server();

  List<String> _manufacturers = [];  

  int selected=-1;

  List<Plane> _toAdd = [];  

  var connectivityResult;

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  @override
  void initState(){
    super.initState();
    db = Db.instance;
    server =new Server(); 

    _refreshList(context);

    connectivityResult= Connectivity().checkConnectivity();

    connectivityResult.then((data){
      connectivityResult=data;
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    // Got a new connectivity status!
      print("Connectivity: " + result.toString());
      connectivityResult=result;
      //connectivityResult.then((val){print("val: "+val.toString());});
      if(result==ConnectivityResult.mobile || result==ConnectivityResult.wifi){  
        print("aici");
        setProgressBar();
        for (Plane plane in _toAdd){
            Server.add(plane);
        }
        setProgressBar();
         //await sync(context);

      }
    });
  
  }

  void setProgressBar(){
    setState(() {
      _progressBarActive=!_progressBarActive;
    });
  }

  // void sync(BuildContext context) async{
  //   if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi){
  //       List<Plane> aircrafts_on_db = await db.getAll();
  //       List<Plane> aircrafts_on_server = await Server.getAll();
  //       print("aircrafts_on_server: "+aircrafts_on_server.toString());
  //       for (Plane aircraft in aircrafts_on_db){
  //         if (!aircrafts_on_server.contains(aircraft)){
  //             db.delete(aircraft.id);
  //         }
  //       }

  //       for (Plane aircraft in aircrafts_on_server){
  //         if (!aircrafts_on_db.contains(aircraft)){
  //             db.add(aircraft);
  //         }
  //       }
  //       setState(() {
  //         _toAdd = [];
  //       });
  //   }

        
  //       _refreshList(context);
  // }

  // getStatus() async{
  //   connectivityResult = await (Connectivity().checkConnectivity());
  //   print("Connectivity: " + connectivityResult.toString());
  // }

  _refreshList(BuildContext context) async {
    if(connectivityResult == ConnectivityResult.none){
      print("connectivityResult == ConnectivityResult.none");
      showSnackBar(context,'The server connection is down.Retry using sync button');
    }
    else{
      print("_refreshList entered");
      setProgressBar();
      List<String> x = await Server.getManufacturers();
      setProgressBar();
      setState(() {
        _manufacturers = x;
      });
    }
    
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold (                    
      appBar: AppBar(
        title: Text('Manage'),
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Reports section'),
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
                     Reports()
                  
                ));
                }
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
    // Future<ConnectivityResult> c= Connectivity().checkConnectivity();
    // ConnectivityResult res;
    // c.then((data){
    //   res=data;
    //   if(res!=ConnectivityResult.mobile && res!=ConnectivityResult.wifi){
    //     print("SnackBarPage should be displayed");
    //     return SnackBarPage();
    //   }
    //   else{
    //     print("else brach reached");
        return ListView.builder(
      padding: const EdgeInsets.only(top:16,left:16,right:16,bottom: 80),
       itemCount: _manufacturers.length*2,
      // The itemBuilder callback is called once per suggested 
      // word pairing, and places each suggestion into a ListTile
      // row. For even rows, the function adds a ListTile row for
      // the word pairing. For odd rows, the function adds a 
      // Divider widget to visually separate the entries. Note that
      // the divider may be difficult to see on smaller devices.
      itemBuilder: (BuildContext _context, int i) {
        // Add a one-pixel-high divider widget before each row 
        // in the ListView.
        if (i.isOdd) {
          return Divider();
        }
        // The syntax "i ~/ 2" divides i by 2 and returns an 
        // integer result.

        final int index = i ~/ 2;
        print("selected: "+selected.toString());
        // if(selected==index){
          
        //   return _buildSelectedRow1(_manufacturers[index], _context);  
        // }
        return _buildRow1(_manufacturers[index], _context);
      }
    );
      //}

    //});


  }

  Widget _buildRow1(String aircraft,BuildContext context) {

    return ListTile(
      title: Text(
        aircraft.toString()+"\n",
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


    onTap: () {      
        getPlanesByManufacturer(aircraft, context);
    },
      

    );
  }


  void getPlanesByManufacturer(String aircraft,BuildContext context) async{
    Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     PlanesByManufacturer(aircraft)
                  
                ));
    
    // if(aircraft!=null){
    //   int result = 0;
    //   db.add(aircraft);
    //     _refreshList(context); 
    //   if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi){
    //     result= await Server.add(aircraft);
        
    //     print("result"+result.toString());
    //   }
    //   if(result==200){
    //     // db.add(aircraft);
    //     // _refreshList(context); 
    //     showSnackBar(context,'The item was successfully created !');
    //   }
    //   else{
    //     setState(() => _toAdd.add(aircraft)); 
    //     showSnackBar(context,'The item was successfully created !(locally)');
    //   }
      
      
    // }
    
  }

  

  void showSnackBar(BuildContext _context,String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(_context).showSnackBar(snackBar);
  }


}
