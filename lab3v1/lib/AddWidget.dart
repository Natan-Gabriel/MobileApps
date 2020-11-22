import 'package:flutter/material.dart';
import 'Aircraft.dart';


class AddWidget extends StatefulWidget {



  final List<Aircraft> _aircrafts;

  AddWidget(this._aircrafts);


  @override
  _AddWidgetState createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  final flightCodeController = TextEditingController();
  final tailNumberController = TextEditingController();
  final airlineController = TextEditingController();
  final aircraftTypeController = TextEditingController();
  final terminalController = TextEditingController();
  final gateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new Padding(
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
                setState(() => widget._aircrafts.add(Aircraft(tailNumberController.text,aircraftTypeController.text,airlineController.text,flightCodeController.text,terminalController.text,gateController.text))); 
                // widget.notifyParent();
                Navigator.pop(context);
                            
              
                //Navigator.pop(context);//
              },
              child: Text(
                "Flat Button",
              ),
            )
          
            ])
           
            );
  }
}