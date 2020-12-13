import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'Aircraft.dart';


class UpdateWidget extends StatefulWidget {

  final Aircraft _aircraft;

  UpdateWidget(this._aircraft);

  @override
  _UpdateWidgetState createState() => _UpdateWidgetState();
}

class _UpdateWidgetState extends State<UpdateWidget> {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  TextEditingController flightCodeController ;//= TextEditingController(text: widget._aircraft.flightCode);
  TextEditingController airlineController;// = TextEditingController();
  TextEditingController aircraftTypeController;// = TextEditingController();
  TextEditingController terminalController;// = TextEditingController();
  TextEditingController gateController;// = TextEditingController();
  


  @override
  Widget build(BuildContext context) {
    return new Padding(
            padding: new EdgeInsets.all(30.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[  

                  Text("Tail number: "+_aircraft.tailNumber,style:  _biggerFont) ,

                  // Padding(padding:new EdgeInsets.only(top: 10),child:Text("Tail number",style:  _biggerFont) ),
                  // // Text("Tail number",style:  _biggerFont) ,
                  // Flexible(
                  //   child:  TextField(
                  //     controller: tailNumberController,          
                  //   ),
                  // ),
                  
                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Aircraft type",style:  _biggerFont) ),
                  // Text("Aircraft type",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: aircraftTypeController=TextEditingController(text: _aircraft.aircraftType),          
                    ),
                  ),


                  
                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Airline",style:  _biggerFont) ),
                  // Text("Airline",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: airlineController=TextEditingController(text: _aircraft.airline),       
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Flight code",style:  _biggerFont) ),
                  // Text("Flight code",style:  _biggerFont) ,
                  
                  Flexible(
                    child:  TextField(
                      controller: flightCodeController=TextEditingController(text: _aircraft.flightCode),
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Terminal",style:  _biggerFont) ),
                  // Text("Terminal",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: terminalController=TextEditingController(text: _aircraft.terminal),          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Gate",style:  _biggerFont) ),
                  // Text("Gate",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: gateController=TextEditingController(text: _aircraft.gate),          
                    ),
                  ),

                  FlatButton(
                      onPressed: () {
                          Aircraft aircraft=Aircraft(_aircraft.tailNumber,aircraftTypeController.text,airlineController.text,flightCodeController.text,terminalController.text,gateController.text);
                          // widget._aircrafts.add(aircraft); 
                          // widget.notifyParent();
                          Navigator.pop(context,aircraft);
                      },
                      child: Text(
                        "UPDATE",
                      ),
                      color: Colors.green,
                  )
          
            ])
           
            );
  }
}