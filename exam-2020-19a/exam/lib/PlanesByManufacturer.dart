





import 'package:airport_manager/ListAircraft.dart';

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

class PlanesByManufacturer extends StatefulWidget {
  final String _aircraft;

  PlanesByManufacturer(this._aircraft);
  @override
  _PlanesByManufacturerState createState() => _PlanesByManufacturerState();
}

class _PlanesByManufacturerState extends State<PlanesByManufacturer> {


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
      List<Plane> x = await Server.getAvailable(widget._aircraft);
      setState(() {
        _manufacturers = x;
      });
    }
    
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold (                    
      appBar: AppBar(
        title: Text('Planes by manufacturer'),
      ),

      //body:Builder(builder: (_context) =>_buildAircrafts1(_context)),// Builder(builder: (_context) =>_buildAircrafts1(_context)),//createTable(),//_buildAircrafts(),//createTable(),  <-if you want the version from previous lab
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      
      body:_buildAircrafts1(),// Builder(builder: (_context) =>_buildAircrafts1(_context)),//createTable(),//_buildAircrafts(),//createTable(),  <-if you want the version from previous lab
      
      );                                      
  }

  Future<void> _showMyDialog(Plane aircraft,BuildContext _context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        
        return AlertDialog(
          title: Text('Alert!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('NO',style: new TextStyle(color: Colors.green)),
              
              onPressed: () {
                Navigator.of(context).pop();
              },
            
              
            ),
            TextButton(
              child: Text('YES',style: new TextStyle(color: Colors.green)),
              onPressed: () async {
                Navigator.of(context).pop();
                // setState(() => _aircrafts.remove(aircraft));
                int result=0;
                if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi){
                  result = await Server.delete(aircraft.id);
                }
                print("result: "+result.toString());
                if(result==200){
                  //db.delete(aircraft.id);
                  _refreshList(_context);
                  showSnackBar(_context, 'The item was successfully deleted !'); 
                }
                
                else{
                  showSnackBar(_context, 'This operation is not available offline!');
                }
              },
            ),
          ],
        );
      },
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

  Widget _buildRow1(Plane aircraft,BuildContext context) {

    return ListTile(
      title: Text(
        aircraft.id.toString()+"\n",
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


    // onTap: () {      
    //     getPlanesByManufacturer(aircraft, context);
    // },
      trailing: FlatButton(
              onPressed: () { _showMyDialog(aircraft,context); },
              child: Text(
                "Delete",
              ),
              color: Colors.red,
            ),
      

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


class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the Scaffold in the widget tree and use
          // it to show a SnackBar.
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}