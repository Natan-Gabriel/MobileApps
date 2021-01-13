import 'package:flutter/material.dart';
import 'Aircraft.dart';
import 'domain/Plane.dart';


class AddWidget extends StatelessWidget {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final statusController = TextEditingController();
  final sizeController = TextEditingController();
  final ownerController = TextEditingController();
  final manufacturerController = TextEditingController();
  final capacityController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new Padding(
            padding: const EdgeInsets.all(30.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[  

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Id",style:  _biggerFont) ),
                  // Text("Tail number",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: idController,          
                    ),
                  ),
                  
                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Name",style:  _biggerFont) ),
                  // Text("Aircraft type",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: nameController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Status",style:  _biggerFont) ),
                  // Text("Airline",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: statusController,          
                    ),
                  ),

                  Text("Size",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: sizeController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Owner",style:  _biggerFont) ),
                  // Text("Terminal",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: ownerController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Manufacturer",style:  _biggerFont) ),
                  // Text("Gate",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: manufacturerController,          
                    ),
                  ),
                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Capacity",style:  _biggerFont) ),
                  // Text("Gate",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: capacityController,          
                    ),
                  ),


                  FlatButton(
                    onPressed: () {
                      // setState(() => widget._aircrafts.add(Aircraft(tailNumberController.text,aircraftTypeController.text,airlineController.text,flightCodeController.text,terminalController.text,gateController.text))); 
                      Plane aircraft=Plane(int.parse(idController.text),nameController.text,statusController.text,int.parse(sizeController.text),ownerController.text,manufacturerController.text,int.parse(capacityController.text));
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