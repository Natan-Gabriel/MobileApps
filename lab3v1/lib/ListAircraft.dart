import 'package:flutter/material.dart';
import 'Aircraft.dart';
import 'AddPage.dart';
import 'package:english_words/english_words.dart';
import 'DeletePage.dart';
import 'DetailPage.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final List<Aircraft> _aircrafts = [Aircraft("G-AAIN","Airbus A320","British Airways","BA0751","Terminal 4","D04"),
                          Aircraft("G-AWIN","Airbus A380","Air France","AF0051","Terminal 4","D05"),
                          Aircraft("G-TYIN","Airbus A330","British Airways","BA0701","Terminal 2","B04"),
                          Aircraft("G-TRIN","Airbus A350","Wizz Air","W60251","Terminal 5","E04"),
                          Aircraft("G-AAEE","Airbus A310","American Airlines","AA0791","Terminal 3","C04"),
                          Aircraft("A-AHGF","Airbus A340","KLM","KL0051","Terminal 4","D06")];  
  final List<WordPair> _suggestions = <WordPair>[];
  final _saved = Set<Aircraft>();     // NEW          // NEW
  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  
  refresh() {
    setState(() {});
  }
  



  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();      // NEW
    // return Text(wordPair.asPascalCase);      // NEW
    return Scaffold (                     // Add from here... 
      appBar: AppBar(
        title: Text('Airport Manager'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Increment',
        child: const Icon(Icons.add),backgroundColor: Colors.red,
      ),
    );                                      // ... to here.
  }

  void updateListView() async {
    setState(() => {});
  }

  void _add() async{
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the AddPage Screen.
    final Aircraft aircraft=await Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     AddPage(_aircrafts)
                  
                ));
    if(aircraft!=null){
      setState(() => _aircrafts.add(aircraft)); 
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
            child: Text('NO'),
            
            onPressed: () {
              Navigator.of(context).pop();
               
            },
            
          ),
          TextButton(
            child: Text('YES'),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() => _aircrafts.remove(aircraft));
            },
          ),
        ],
      );
    },
  );
}

  void _delete(Aircraft aircraft) {
    setState(() => _aircrafts.remove(aircraft)); 
  }


  void _detail(Aircraft aircraft) async{
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the AddPage Screen.
    final Aircraft resultAircraft=await Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     DetailPage(aircraft)
                  
                ));
    if(resultAircraft!=null){
      setState(() => _aircrafts.add(aircraft)); 
    }
  }

    void _pushSaved() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (Aircraft pair) {
              return ListTile(
                title: Text(
                  pair.flightCode+"    "+
                  pair.terminal+"    "+
                  pair.gate,
                  
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
  );
  }


    Widget _buildSuggestions() {
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
        // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
        // This calculates the actual number of word pairings 
        // in the ListView,minus the divider widgets.
        final int index = i ~/ 2;
        // If you've reached the end of the available word
        // pairings...
        return _buildRow(_aircrafts[index]);
      }
    );
  }

  Widget _buildRow(Aircraft pair) {

    return ListTile(
      title: Text(
        pair.flightCode+"    "+
        pair.terminal+"    "+
        pair.gate,
        style: _biggerFont,
      ),

      trailing: FlatButton(
              onPressed: () { _showMyDialog(pair); },
              child: Text(
                "Delete",
              ),
              color: Colors.red,
            ),

      onTap: () {      // NEW lines from here...
        _detail(pair);
    },

    );
  }


}