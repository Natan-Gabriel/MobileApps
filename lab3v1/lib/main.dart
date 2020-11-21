import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random(); // Add this line.
    return MaterialApp(
      title: 'Airport Manager',
      theme: ThemeData(          // Add the 3 lines from here... 
        primaryColor: Colors.green,
      ),                         // ... to here.
      home: RandomWords(),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}


class Aircraft {
  Aircraft(this.tailNumber, this.aircraftType,this.airline,this.flightCode,this.terminal,this.gate);

  final String tailNumber;
  final String aircraftType;
  final String airline;
  final String flightCode;
  final String terminal;
  final String gate;

}

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

  final flightCodeController = TextEditingController();
  final tailNumberController = TextEditingController();
  final airlineController = TextEditingController();
  final aircraftTypeController = TextEditingController();
  final terminalController = TextEditingController();
  final gateController = TextEditingController();

  

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
        child: const Icon(Icons.add),
      ),
    );                                      // ... to here.
  }

  void _add(){
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
      

          return Scaffold(
            appBar: AppBar(
              title: Text('Add an aircraft'),
            ),
            // body:  RichText(
            //         text: TextSpan(
            //           children: <TextSpan>[
            //             TextSpan(text: 'hello', style: _biggerFont ,color:Colors.black ),
            //             TextSpan(text: ' world', style: TextStyle(color: Colors.blue)),
            //           ],
            //         ),
            //       ),
            body: new Padding(
            padding: new EdgeInsets.all(30.0),
            child:Column(
              
              children: <Widget>[
              Row(children:[
                Text("BA0751",style:  _biggerFont)  ,
                Text("Hello",style: _biggerFont)   ]
            ),
             
            Text("Flight code",style:  _biggerFont) ,
            Flexible(
              child:  TextField(
                controller: flightCodeController,          
              ),
            ),

            Text("Tail number",style:  _biggerFont) ,
            Flexible(
              child:  TextField(
                controller: tailNumberController,          
              ),
            ),

            Text("Airline",style:  _biggerFont) ,
            Flexible(
              child:  TextField(
                controller: airlineController,          
              ),
            ),
            
            Text("Aircraft type",style:  _biggerFont) ,
            Flexible(
              child:  TextField(
                controller: aircraftTypeController,          
              ),
            ),

            Text("Terminal",style:  _biggerFont) ,
            Flexible(
              child:  TextField(
                controller: terminalController,          
              ),
            ),

            Text("Gate",style:  _biggerFont) ,
            Flexible(
              child:  TextField(
                controller: gateController,          
              ),
            ),
    
          Flexible(
            child:
          TextField(
         
          onSubmitted: (String value) async {
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Thanks!'),
                  content: Text(flightCodeController.text),//Text('You typed "$value".'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
        ),
            ),

        
            FlatButton(
              onPressed: () {
               setState(() => _aircrafts.add(Aircraft(tailNumberController.text,aircraftTypeController.text,airlineController.text,flightCodeController.text,terminalController.text,gateController.text)));               
              
                Navigator.pop(context);//
              },
              child: Text(
                "Flat Button",
              ),
            )
          
            ])
           
            )
          );
        }, // ...to here.
      ),
  );
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
        if (index >= _suggestions.length) {
          // ...then generate 10 more and add them to the 
          // suggestions list.
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_aircrafts[index]);
      }
    );
  }

  Widget _buildRow(Aircraft pair) {
    final alreadySaved = _saved.contains(pair);  // NEW
    return ListTile(
      title: Text(
        pair.flightCode+"    "+
        pair.terminal+"    "+
        pair.gate,
        style: _biggerFont,
      ),
      trailing: Icon(   // NEW from here... 
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
    ),                // ... to here.
    onTap: () {      // NEW lines from here...
      setState(() {
        if (alreadySaved) {
          _saved.remove(pair);
        } else { 
          _saved.add(pair); 
        } 
      });
    },               // ... to here.
    );
  }


}