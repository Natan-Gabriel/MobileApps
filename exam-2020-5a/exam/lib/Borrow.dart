


import 'dart:convert';

import 'package:airport_manager/MainList.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'Reports.dart';
import 'crud/SetName.dart';
import 'domain/Book.dart';
import 'server/server.dart';
import 'crud/BorrowWidget.dart';
import 'package:flutter/material.dart';
import 'database/database.dart';
import 'dart:developer' as developer;
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Borrow extends StatefulWidget {
  final channel = IOWebSocketChannel.connect('ws://10.0.2.2:2501');
  @override
  _BorrowState createState() => _BorrowState(channel:channel);
}

class _BorrowState extends State<Borrow> {


  bool _progressBarActive = false;
  final WebSocketChannel channel;

  _BorrowState({this.channel}) {
    channel.stream.listen((data) {
      print("Websocket works!!.Data: "+data.toString());
      Map userMap = jsonDecode(data);
      var data_decoded = Book.fromMap(userMap);
      //showSnackBar(__context, "Websocket works!!");
      String message="Another user just added a book. The book has the title: "+data_decoded.title+", it has: "+data_decoded.status.toString()+" pages and the usedCount is: "+data_decoded.usedCount.toString();
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

  List<Book> _aircrafts = [];  

  List<Book> _toAdd = [];  

  //final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');


  var connectivityResult;

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  @override
  void initState() {
    super.initState();
    //db = Db.instance;
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
        for (Book plane in _toAdd){
            Server.add(plane);
        }
        setProgressBar();
         await sync(context);

      }
    });
  
  }

  void sync(BuildContext context) async{
    try{
      if(connectivityResult==ConnectivityResult.mobile || connectivityResult==ConnectivityResult.wifi){
          //String student=await getRecord();
          setProgressBar();
          List<Book> aircrafts_on_server = await Server.getAvailable();
          print("aircrafts_on_server: "+aircrafts_on_server.toString());
          
          setProgressBar();

      }

          
          _refreshList(context);
    }
    catch(exp){
      showSnackBar(__context, exp.toString());
    }
  }

  void setProgressBar(){
    setState(() {
      _progressBarActive=!_progressBarActive;
    });
  }

  _refreshList(BuildContext context) async {
    try{
      if(connectivityResult == ConnectivityResult.none){
        print("connectivityResult == ConnectivityResult.none");
        showSnackBar(__context,'The server connection is down.Retry using sync button');
      }
      else{
        print("_refreshList entered");
        String user=await getRecord();
        setProgressBar();
        List<Book> x = await Server.getAvailable();
        print("x: "+x.toString());
        setProgressBar();
        setState(() {
          _aircrafts = x;
        });
      }
      
    }
    catch(exp){
      showSnackBar(__context, exp.toString());
    }
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


  @override
  Widget build(BuildContext context) {

    return Scaffold (                    
      appBar: AppBar(
        title: Text('Borrow'),
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
              title: Text('Owner section'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                    MainList()
                  
                ));
                
              },
            ),
            ListTile(
              title: Text('Borrow section'),
              onTap: () {
                if(connectivityResult!=ConnectivityResult.mobile && connectivityResult!=ConnectivityResult.wifi){
                  Navigator.pop(context);
                  showSnackBar(_context, "Please connect to the internet");
                }
                else{
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     Borrow()
                  
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

      // floatingActionButton: Builder(builder: (context) => FloatingActionButton(
      //   onPressed : () => _add(context),
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),backgroundColor: Colors.green,
      // )
      

    );                                      
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

  Future<void> _showMyDialog(Book aircraft,BuildContext _context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        
        return AlertDialog(
          title: Text('Alert!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to borrow this item?'),
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
                  String student= await getRecord();
                  result = await Server.borrow(aircraft.id,student);
                }
                if(result==200){
                  //db.delete(aircraft.id);
                  _refreshList(_context);
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

  Widget _buildRow1(Book entity,BuildContext context) {

    return ListTile(
      title: Text(
        "title: "+entity.title.toString()+"\n"+
        "pages: "+entity.pages.toString()+"\n"+
        "usedCount: "+entity.usedCount.toString()+"\n",
        
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
        _showMyDialog(entity, context);
    },

    );
  }

  void showSnackBar(BuildContext _context,String message){
    final snackBar = SnackBar(content: Text(message),duration: Duration(seconds: 2 ));
    Scaffold.of(__context).showSnackBar(snackBar);
  }


}