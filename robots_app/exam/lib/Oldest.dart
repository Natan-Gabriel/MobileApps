

import 'dart:async';
import 'dart:convert';

import 'package:airport_manager/domain/Robot.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'MainList.dart';
import 'crud/AddWidget.dart';

import 'crud/SetName.dart';
import 'crud/UpdateWidget.dart';
import 'crud/UpdateWidget2.dart';
import 'domain/Book.dart';
import 'server/server.dart';
import 'package:flutter/material.dart';
import 'database/database.dart';
import 'dart:developer' as developer;
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

class Oldest extends StatefulWidget {

  Oldest();
  @override
  _OldestState createState() => _OldestState();
}

class _OldestState extends State<Oldest> with AfterLayoutMixin<Oldest>{


  @override
  Widget build(BuildContext context) {

    return Scaffold (                    
      appBar: AppBar(
        title: Text('Owner Section'),
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

      
      body: Builder(builder: (_context) => _buildList(_context)),//createTable(),//_buildAircrafts(),//createTable(),  <-if you want the version from previous lab
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
              title: Text('Main section'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     MainList()
                  
                ));
              },
            ),
            ListTile(
              title: Text('Oldest'),
              onTap: () {
                Navigator.pop(context);
                 
                
                

              },
            ),
           
          ],
        ),
        )
      ),
      
      floatingActionButton: Builder(builder: (context) => FloatingActionButton(
        //onPressed : () => _add(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),backgroundColor: Colors.green,
      )
      ),

    );                                      
  }

  @override
  void afterFirstLayout(BuildContext context){
    sync(__context);
  }


  bool _progressBarActive = false;
  IOWebSocketChannel channel;
  BuildContext __context;
  Db db; 
  Server server;
  List<Robot> _entities = [];  
  // List<Book> _toAdd = []; 
  var connectivityResult;
  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW



void websocket(){
    channel.stream.listen((data) {
      print("Websocket works!!.Data: "+data.toString());
      Map userMap = jsonDecode(data);
      var data_decoded = Robot.fromMap(userMap);
      //showSnackBar(__context, "Websocket works!!");
      String message="A robot was added. The robot has id : "+data_decoded.id.toString()+", name: "+data_decoded.name.toString()+" specs:"+data_decoded.specs.toString()+" height:"+data_decoded.height.toString()+" type:"+data_decoded.type.toString()+" and age:"+data_decoded.age.toString();
      //customDialog(message,__context);
      //initState(() {});
      sync(__context);
      print("__context here1 is: "+__context.toString());
      //customDialog(message,__context);
      showSnackBar(__context, message);
    },
    onDone: () {
          print('ws channel closed');
        },
    );
  }
  
  @override
  void initState() {
    super.initState();
    
    db = Db.instance;
    server =new Server(); 

    connectivityResult= Connectivity().checkConnectivity();

    connectivityResult.then((data){
      connectivityResult=data;
    });

    //sync(__context);

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    // Got a new connectivity status!
      print("Connectivity: " + result.toString());
      connectivityResult=result;
      if(result==ConnectivityResult.mobile || result==ConnectivityResult.wifi){  
        channel = IOWebSocketChannel.connect('ws://10.0.2.2:2202');
        websocket(); //start websocket
        print("aici");
        setProgressBar();
        
        
        setProgressBar();
        await sync(context);

      }
    });
  
  }
  

  void sync(BuildContext context) async{
    try{
      
      _refreshList(context);
    }
    catch(exp){
      if(_progressBarActive==true){
        setProgressBar();
      }
      showSnackBar(__context, exp.toString());
    }
  }


  _refreshList(BuildContext context) async {
    try{
      setProgressBar();
      List<Robot> l=await Server.getOldest();
      setProgressBar();
      setState(() {
        _entities = l;
      });
      if(connectivityResult == ConnectivityResult.none){
        print("connectivityResult == ConnectivityResult.none");
        showSnackBar(__context,'The server connection is down.Retry using sync button');
      }
    }
    catch(exp){
      if(_progressBarActive==true){
        setProgressBar();
      }
      showSnackBar(__context, exp.toString());
    }
  }

  void setProgressBar(){
    setState(() {
      _progressBarActive=!_progressBarActive;
    });
  }

  void record(String str) async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString('user', str);
  }

  getRecord() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('user');
  }



  
  void setName(BuildContext context) async{
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the AddPage Screen.

      final String str=await Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                      SetNameWidget()
                    
                  ));
      
      if(str!=null){
          record(str);
        }
      sync(__context);
  
  }
  
  
  // void _add(BuildContext context) async{
  //   // Navigator.push returns a Future that completes after calling
  //   // Navigator.pop on the AddPage Screen.
  //   try{
  //     final Book entity=await Navigator.push(context, MaterialPageRoute(
  //                   builder: (context) =>
  //                     AddWidget()
                    
  //                 ));
    
      
  //     if(entity!=null){
  //       String student=await getRecord();
  //       entity.setStudent(student);
  //       int result = 0;
  //       setProgressBar();
  //       await db.addBorrowed(entity);
  //       setProgressBar();
  //       //_refreshList(context); 
  //       if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi){
  //         setProgressBar();
  //         try{
  //           result= await Server.add(entity);
  //         }
  //         catch(exp){
  //           print("__context here2 is: "+__context.toString());
  //           showSnackBar(__context, exp.toString());
  //         }
  //         setProgressBar();
          
  //         print("result"+result.toString());
  //       }
  //       // sync(context);
  //       if(result==200){

  //         showSnackBar(context,'The item was successfully created !');
  //       }
  //       else if(result!=404){
  //         await db.addToAdd(entity);
  //         //showSnackBar(context,'The item was successfully created !(locally)');
  //       }

  //       sync(context);
        
        
  //     }
  //   }
  //   catch(exp){
  //     showSnackBar(__context, exp.toString());
  //   }
    
  // }

  void _detail(Robot entity,BuildContext context) async{
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the AddPage Screen.
    try{
      
      final int resultEntity=await Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                      UpdateWidget2(entity)
                    
                  ));
      if(resultEntity!=null){
        // setState(() => _entities[_entities.indexOf(aircraft)] = resultAircraft); 
        
        if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi){
          //print("dada"+resultEntity[0].toString()+resultEntity[1].toString());
          await Server.updateAge(entity.id,resultEntity);
          sync(context);
        }
        
      }
    }
    catch(exp){
      showSnackBar(__context, exp.toString());
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

  Future<void> _showMyDialog(Book entity,BuildContext _context) async {
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
                // setState(() => _entities.remove(aircraft));
                int result=0;
                if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi){
                  result = await Server.delete(entity.id);
                }
                if(result==200){
                  //db.delete(aircraft.id);
                  //_refreshList(_context);
                  sync(__context);
                  showSnackBar(_context, 'The operation was successfully !'); 
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

    Widget _buildList(BuildContext _context) {
    
      __context=_context;
      //await ()async {setProgressBar(); _entities = await db.getAllBorrowed();setProgressBar();}
      //print("_entities aici: "+_entities.toString());
      //sync(__context);
    return ListView.builder(
      padding: const EdgeInsets.only(top:16,left:16,right:16,bottom: 80),
       itemCount: _entities.length*2,
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
        return _buildRow(_entities[index], _context);
      }
    );
  }

  Widget _buildRow(Robot entity,BuildContext context) {

    return ListTile(
      title: Text(
        
        "name: "+entity.name.toString()+"\n"+
        "specs: "+entity.specs.toString()+"\n"+
        "type: "+entity.type.toString()+"\n"+
        "age: "+entity.age.toString()+"\n",
        
        style: _biggerFont,
      ),
      
      onTap: () {      
        _detail(entity, context);
    },

    );
  }

  void showSnackBar(BuildContext _context,String message){
    final snackBar = SnackBar(content: Text(message),duration: Duration(seconds: 2 ));
    Scaffold.of(__context).showSnackBar(snackBar);
  }


}