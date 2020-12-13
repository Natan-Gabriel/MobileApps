import 'package:flutter/material.dart';
import 'Aircraft.dart';
import 'UpdatePage.dart';

class DetailWidget extends StatelessWidget {

  final Aircraft _aircraft;

  DetailWidget(this._aircraft);

  final TextStyle _biggerFont = const TextStyle(fontSize: 30);

  @override
  Widget build(BuildContext context) {
    return new Padding(
            padding: new EdgeInsets.all(30.0),
            
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            
            Text("Aircraft type: "+_aircraft.aircraftType,style:  _biggerFont) ,

            Text("Airline: "+_aircraft.airline,style:  _biggerFont) ,

            Text("Flight code: "+_aircraft.flightCode,style:  _biggerFont) ,
            
            Text("Terminal: "+_aircraft.terminal,style:  _biggerFont) ,
            
            Text("Gate: "+_aircraft.gate,style:  _biggerFont) ,
        
            FlatButton(
              onPressed: () {
                // setState(() => widget._aircrafts.add(Aircraft(tailNumberController.text,aircraftTypeController.text,airlineController.text,flightCodeController.text,terminalController.text,gateController.text))); 
                //Aircraft aircraft=Aircraft(tailNumberController.text,aircraftTypeController.text,airlineController.text,flightCodeController.text,terminalController.text,gateController.text);
                // widget._aircrafts.add(aircraft); 
                // widget.notifyParent();
                // Navigator.pop(context);
                _update(_aircraft,context); 
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) =>
                //      UpdatePage(widget._aircraft)
                  
                // ));
              
                // Navigator.pop(context);//
              },
              child: Text(
                "Update",
                style: _biggerFont,
                
              ),
              color: Colors.blue,
            )
          
            ])
           
            );
  }

  void _update(Aircraft aircraft,BuildContext context) async{
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the AddPage Screen.
    final Aircraft resultAircraft=await Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     UpdatePage(aircraft)
                  
                ));
    if(resultAircraft!=null){//somehow optional
      Navigator.pop(context,resultAircraft);
    }
  }


}