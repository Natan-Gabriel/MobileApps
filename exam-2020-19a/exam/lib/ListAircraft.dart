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

class ListAircraft extends StatefulWidget {
  @override
  _ListAircraftState createState() => _ListAircraftState();
}

class _ListAircraftState extends State<ListAircraft> {

  Db db; 
  Server server;//=new Server();

  List<Plane> _aircrafts = [];  

  List<Plane> _toAdd = [];  

  var connectivityResult;

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  @override
  void initState() {
    super.initState();
    db = Db.instance;
    server =new Server(); 

    // getStatus();
    
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    // Got a new connectivity status!
      print("Connectivity: " + result.toString());
      connectivityResult=result;
      if(result==ConnectivityResult.mobile || result==ConnectivityResult.wifi){  
        print("aici");
        for (Plane plane in _toAdd){
            Server.add(plane);
        }
         await sync();
         setState(() {
          _toAdd = [];
        });

        _refreshList(context); 

      }
    });
    

    _refreshList(context);
  }

  void sync() async{
    List<Plane> aircrafts_on_db = await db.getAll();
        List<Plane> aircrafts_on_server = await Server.getAll();
        print("aircrafts_on_server: "+aircrafts_on_server.toString());
        for (Plane aircraft in aircrafts_on_db){
          if (!aircrafts_on_server.contains(aircraft)){
              ;//db.delete(aircraft.id);
          }
        }

        for (Plane aircraft in aircrafts_on_server){
          if (!aircrafts_on_db.contains(aircraft)){
              db.add(aircraft);
          }
        }

        
        _refreshList(context);
  }

  // getStatus() async{
  //   connectivityResult = await (Connectivity().checkConnectivity());
  //   print("Connectivity: " + connectivityResult.toString());
  // }

  _refreshList(BuildContext context) async {
    List<Plane> x = await db.getAll();
    setState(() {
      _aircrafts = x;
    });
    if(connectivityResult == ConnectivityResult.none){
      showSnackBar(context,'The server connection is down');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold (                    
      appBar: AppBar(
        title: Text('Planes App'),
        leading: FlatButton(
    onPressed: () { sync(); },
    child: Icon(
      Icons.sync,  // add custom icons also
    ),
  ),
      ),
      body: _buildAircrafts1(),//createTable(),//_buildAircrafts(),//createTable(),  <-if you want the version from previous lab
      floatingActionButton: Builder(builder: (context) => FloatingActionButton(
        onPressed : () => _add(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),backgroundColor: Colors.green,
      )
      )
      );                                      
  }


  void _add(BuildContext context) async{
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the AddPage Screen.
    final Plane aircraft=await Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     AddPage()
                  
                ));
    
    if(aircraft!=null){
      int result = 0;
      db.add(aircraft);
        _refreshList(context); 
      if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi){
        result= await Server.add(aircraft);
        
        print("result"+result.toString());
      }
      if(result==200){
        // db.add(aircraft);
        // _refreshList(context); 
        showSnackBar(context,'The item was successfully created !');
      }
      else{
        setState(() => _toAdd.add(aircraft)); 
        showSnackBar(context,'The item was successfully created !(locally)');
      }
      
      
    }
    
  }

  void _detail(Plane aircraft,BuildContext context) async{
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the AddPage Screen.
    final Aircraft resultAircraft=await Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     DetailPage(aircraft)
                  
                ));
    if(resultAircraft!=null){
      // setState(() => _aircrafts[_aircrafts.indexOf(aircraft)] = resultAircraft); 
      int result=0;
      if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi){
        result= await Server.update(resultAircraft);
      }
      if(result==200){
        db.update(resultAircraft);
        _refreshList(context); 
        showSnackBar(context,'The item was successfully updated !');
      }
      else{
        showSnackBar(context,'This operation is not available offline!');
      }

    }
    
     
  }

  Future<void> _showMyDialog(Aircraft aircraft,BuildContext _context) async {
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
                  result = await Server.delete(aircraft.tailNumber);
                }
                if(result==200){
                  db.delete(aircraft.tailNumber);
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

    Widget _buildAircrafts1() {
    return ListView.builder(
      padding: const EdgeInsets.only(top:16,left:16,right:16,bottom: 80),
       itemCount: _aircrafts.length*2,
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
        return _buildRow1(_aircrafts[index], _context);
      }
    );
  }

  Widget _buildRow1(Plane aircraft,BuildContext context) {

    return ListTile(
      title: Text(
        "id: "+aircraft.id.toString()+"\n",
        
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
        _detail(aircraft, context);
    },

    );
  }

  void showSnackBar(BuildContext _context,String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(_context).showSnackBar(snackBar);
  }


}