import 'dart:convert';

import 'package:airport_manager/ManageSection.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'Reports.dart';
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
  final channel = IOWebSocketChannel.connect('ws://10.0.2.2:1876');
  @override
  _ListAircraftState createState() => _ListAircraftState(channel:channel);
}

class _ListAircraftState extends State<ListAircraft> {


  bool _progressBarActive = false;
  final WebSocketChannel channel;

  _ListAircraftState({this.channel}) {
    channel.stream.listen((data) {
      print("Websocket works!!.Data: "+data.toString());
      Map userMap = jsonDecode(data);
      var data_decoded = Plane.fromMap(userMap);
      //showSnackBar(__context, "Websocket works!!");
      String message="Another user just added a plane. The plane has the name: "+data_decoded.name+", the size: "+data_decoded.size.toString()+" and the owner: "+data_decoded.owner;
      //customDialog(message,__context);
      //initState(() {});
      sync(__context);
      print("__context here1 is: "+__context.toString());
      //customDialog(message,__context);
      showSnackBar(__context, message);
    });
  }

  BuildContext __context;

  Db db; 
  Server server;//=new Server();

  List<Plane> _aircrafts = [];  

  List<Plane> _toAdd = [];  

  //final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');


  var connectivityResult;

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  @override
  void initState() {
    super.initState();
    db = Db.instance;
    server =new Server(); 

    sync(__context);

    //_refreshList(context);

   // showSnackBar(__context, message);

    connectivityResult= Connectivity().checkConnectivity();

    connectivityResult.then((data){
      connectivityResult=data;
    });
    // connectivityResult.then((val){print("val: "+val.toString());});
    
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    // Got a new connectivity status!
      print("Connectivity: " + result.toString());
      connectivityResult=result;
      if(result==ConnectivityResult.mobile || result==ConnectivityResult.wifi){  
        print("aici");
        setProgressBar();
        for (Plane plane in _toAdd){
            Server.add(plane);
        }
        setProgressBar();
         await sync(context);

      }
    });
  
  }

  void sync(BuildContext context) async{

    if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi){
        setProgressBar();
        List<Plane> aircrafts_on_db = await db.getAll();
        List<Plane> aircrafts_on_server = await Server.getAll();
        print("aircrafts_on_server: "+aircrafts_on_server.toString());
        for (Plane aircraft in aircrafts_on_db){
          if (!aircrafts_on_server.contains(aircraft)){
              db.delete(aircraft.id);
          }
        }

        for (Plane aircraft in aircrafts_on_server){
          if (!aircrafts_on_db.contains(aircraft)){
              db.add(aircraft);
          }
        }
        setProgressBar();
        setState(() {
          _toAdd = [];
        });
    }

        
        _refreshList(context);
  }

  void setProgressBar(){
    setState(() {
      _progressBarActive=!_progressBarActive;
    });
  }

  // getStatus() async{
  //   connectivityResult = await (Connectivity().checkConnectivity());
  //   print("Connectivity: " + connectivityResult.toString());
  // }

  _refreshList(BuildContext context) async {
    print("_refreshList entered");
    List<Plane> x = await db.getAll();
    setState(() {
      _aircrafts = x;
    });
    if(connectivityResult == ConnectivityResult.none){
      print("connectivityResult == ConnectivityResult.none");
      showSnackBar(__context,'The server connection is down.Retry using sync button');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold (                    
      appBar: AppBar(
        title: Text('Registration'),
        bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 1.0),
                  child: _progressBarActive == true?const LinearProgressIndicator(
                    backgroundColor: Colors.black,
                  ):new Container(),
        ),

        actions: <Widget>[
                Builder(builder: (context) =>IconButton(
                  icon: Icon(Icons.sync),
                  onPressed: () { sync(context); },
                ),
                ),
        ],
      ),

      
      body: Builder(builder: (_context) => _buildAircrafts1(_context)),//createTable(),//_buildAircrafts(),//createTable(),  <-if you want the version from previous lab
      drawer: Drawer(
        child: Builder(builder: (_context) => ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children:  <Widget>[
            DrawerHeader(
              child: Text('Drawer'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Registration section'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Manage section'),
              onTap: () {
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

      floatingActionButton: Builder(builder: (context) => FloatingActionButton(
        onPressed : () => _add(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),backgroundColor: Colors.green,
      )
      ),

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
      setProgressBar();
      db.add(aircraft);
      setProgressBar();
        _refreshList(context); 
      if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi){
        setProgressBar();
        try{
          result= await Server.add(aircraft);
        }
        catch(exp){
          print("__context here2 is: "+__context.toString());
          showSnackBar(__context, exp.toString());
        }
        setProgressBar();
        
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
        setProgressBar();
        db.update(resultAircraft);
        setProgressBar();
        _refreshList(context); 
        showSnackBar(context,'The item was successfully updated !');
      }
      else{
        showSnackBar(context,'This operation is not available offline!');
      }

    }
    
     
  }

  Future<void> customDialog(String message,BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        
        return AlertDialog(
          title: Text('Notification'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok',style: new TextStyle(color: Colors.green)),
              
              onPressed: () {
                Navigator.of(context).pop();
              },
            
              
            ),
            
          ],
        );
      },
    );
}

//   Future<void> _showMyDialog(Aircraft aircraft,BuildContext _context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
        
//         return AlertDialog(
//           title: Text('Alert!'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Are you sure you want to delete this item?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('NO',style: new TextStyle(color: Colors.green)),
              
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
            
              
//             ),
//             TextButton(
//               child: Text('YES',style: new TextStyle(color: Colors.green)),
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                 // setState(() => _aircrafts.remove(aircraft));
//                 int result=0;
//                 if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi){
//                   result = await Server.delete(aircraft.tailNumber);
//                 }
//                 if(result==200){
//                   //db.delete(aircraft.id);
//                   _refreshList(_context);
//                   showSnackBar(_context, 'The item was successfully deleted !'); 
//                 }
//                 else{
//                   showSnackBar(_context, 'This operation is not available offline!');
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
// }  

    Widget _buildAircrafts1(BuildContext _context) {
      __context=_context;
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
    final snackBar = SnackBar(content: Text(message),duration: Duration(seconds: 2 ));
    Scaffold.of(__context).showSnackBar(snackBar);
  }


}