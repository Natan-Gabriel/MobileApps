import 'package:flutter/material.dart';
import 'Aircraft.dart';


class UpdateWidget extends StatefulWidget {

  final Aircraft _aircraft;

  UpdateWidget(this._aircraft);

  @override
  _UpdateWidgetState createState() => _UpdateWidgetState();
}

class _UpdateWidgetState extends State<UpdateWidget> {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  final flightCodeController = TextEditingController();
  final airlineController = TextEditingController();
  final aircraftTypeController = TextEditingController();
  final terminalController = TextEditingController();
  final gateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new Padding(
            padding: new EdgeInsets.all(30.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[  

                  Text("Tail number: "+widget._aircraft.tailNumber,style:  _biggerFont) ,

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
                      controller: aircraftTypeController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Airline",style:  _biggerFont) ),
                  // Text("Airline",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: airlineController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Flight code",style:  _biggerFont) ),
                  // Text("Flight code",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: flightCodeController,          
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
                          Aircraft aircraft=Aircraft(widget._aircraft.tailNumber,aircraftTypeController.text,airlineController.text,flightCodeController.text,terminalController.text,gateController.text);
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