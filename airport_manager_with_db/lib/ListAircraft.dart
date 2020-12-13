import 'package:airport_manager/size_config/size_config.dart';
import 'package:flutter/material.dart';
import 'Aircraft.dart';
import 'AddPage.dart';
import 'DetailPage.dart';
import 'database/database.dart';
import 'dart:developer' as developer;

class ListAircraft extends StatefulWidget {
  @override
  _ListAircraftState createState() => _ListAircraftState();
}

class _ListAircraftState extends State<ListAircraft> {

  Db db; 

  List<Aircraft> _aircrafts = [];  
  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  @override
  void initState() {
    super.initState();
    db = Db.instance;
    _refreshList();
  }

  _refreshList() async {
    List<Aircraft> x = await db.getAll();
    setState(() {
      _aircrafts = x;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold (                    
      appBar: AppBar(
        title: Text('Airport Manager'),
        
      ),
      body: _buildAircrafts1(),//createTable(),//_buildAircrafts(),//createTable(),  <-if you want the version from previous lab
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Increment',
        child: const Icon(Icons.add),backgroundColor: Colors.green,
      ),
    );                                      
  }


  void _add() async{
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the AddPage Screen.
    final Aircraft aircraft=await Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     AddPage()
                  
                ));
    if(aircraft!=null){
      db.add(aircraft);
      _refreshList(); 
    }
  }

  void _detail(Aircraft aircraft) async{
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the AddPage Screen.
    final Aircraft resultAircraft=await Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     DetailPage(aircraft)
                  
                ));
    if(resultAircraft!=null){
      // setState(() => _aircrafts[_aircrafts.indexOf(aircraft)] = resultAircraft); 
      db.update(resultAircraft);
      _refreshList(); 
    }
  }

  Future<void> _showMyDialog(Aircraft aircraft) async {
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
              onPressed: () {
                Navigator.of(context).pop();
                // setState(() => _aircrafts.remove(aircraft));
                db.delete(aircraft.tailNumber);
                _refreshList(); 
              },
            ),
          ],
        );
      },
    );
}  

    Widget createTable() {
      List<DataColumn> _columns = [];
      List<DataRow> _rows = [];
      _columns.add(DataColumn(label:Text("Flight\ncode",textScaleFactor: 1.5)));
      _columns.add(DataColumn(label:Text("Terminal",textScaleFactor: 1.5)));
      _columns.add(DataColumn(label:Text("Gate",textScaleFactor: 1.5)));
      _columns.add(DataColumn(label:Text("",textScaleFactor: 1.5)));

      for (int i = 0; i < _aircrafts.length;++i) {
        _rows.add(_createRow(_aircrafts[i]));
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.only(top:20.0,bottom:80.0),
        
        child:DataTable(
              columnSpacing: 10.0,
              showCheckboxColumn: false,
              columns: _columns,
              rows: _rows
            ));

    }

    Widget customContainer(String str){
    return Container(
      width: SizeConfig.blockSizeHorizontal * 20,
      child: Text(str,textScaleFactor: 1.5),
    );
  }

  DataRow _createRow(Aircraft aircraft) {

    return  DataRow(cells:<DataCell> [
          DataCell(customContainer(aircraft.flightCode)),
          DataCell(customContainer(aircraft.terminal)),
          DataCell(customContainer(aircraft.gate)),
          DataCell(Container(
              width: SizeConfig.blockSizeHorizontal * 19,
              child:FlatButton(
              
              onPressed: () { _showMyDialog(aircraft); },
              child: Text(
                "Delete",
              ),
              color: Colors.red,
            ))),
        ],
        onSelectChanged: (bool selected) {
                if (selected) {
                    _detail(aircraft);
                }
            }
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
        return _buildRow1(_aircrafts[index]);
      }
    );
  }

  Widget _buildRow1(Aircraft aircraft) {

    return ListTile(
      title: Text(
        "Flight code: "+aircraft.flightCode+"\n",
        
        style: _biggerFont,
      ),
      isThreeLine: true,
      subtitle: Text("Terminal: "+aircraft.terminal+"\n"+
        "Gate: "+aircraft.gate),

      trailing: FlatButton(
              onPressed: () { _showMyDialog(aircraft); },
              child: Text(
                "Delete",
              ),
              color: Colors.red,
            ),

      onTap: () {      
        _detail(aircraft);
    },

    );
  }

  Widget _buildAircrafts() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
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
        return _buildRow(_aircrafts[index]);
      }
    );
  }

  Widget _buildRow(Aircraft aircraft) {

    return ListTile(
      title: Text(
        aircraft.flightCode+"    "+
        aircraft.terminal+"    "+
        aircraft.gate,
        style: _biggerFont,
      ),

      trailing: FlatButton(
              onPressed: () { _showMyDialog(aircraft); },
              child: Text(
                "Delete",
              ),
              color: Colors.red,
            ),

      onTap: () {      
        _detail(aircraft);
    },

    );
  }



}