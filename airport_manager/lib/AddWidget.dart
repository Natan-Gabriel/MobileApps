import 'package:flutter/material.dart';
import 'Aircraft.dart';


class AddWidget extends StatefulWidget {

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
            padding: const EdgeInsets.all(30.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[  

                  Text("Flight code",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: flightCodeController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Tail number",style:  _biggerFont) ),
                  // Text("Tail number",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: tailNumberController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Airline",style:  _biggerFont) ),
                  // Text("Airline",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: airlineController,          
                    ),
                  ),
                  
                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Aircraft type",style:  _biggerFont) ),
                  // Text("Aircraft type",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: aircraftTypeController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Terminal",style:  _biggerFont) ),
                  // Text("Terminal",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: terminalController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Gate",style:  _biggerFont) ),
                  // Text("Gate",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: gateController,          
                    ),
                  ),

                  FlatButton(
                    onPressed: () {
                      // setState(() => widget._aircrafts.add(Aircraft(tailNumberController.text,aircraftTypeController.text,airlineController.text,flightCodeController.text,terminalController.text,gateController.text))); 
                      Aircraft aircraft=Aircraft(tailNumberController.text,aircraftTypeController.text,airlineController.text,flightCodeController.text,terminalController.text,gateController.text);
                      // widget._aircrafts.add(aircraft); 
                      // widget.notifyParent();
                      Navigator.pop(context,aircraft);
                                  
                    
                      //Navigator.pop(context);//
                    },
                    child: Text(
                      "Add",),
                    color: Colors.green,
                  )
              
            ])
           
            );
  }
}