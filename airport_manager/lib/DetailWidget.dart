import 'package:flutter/material.dart';
import 'Aircraft.dart';
import 'UpdatePage.dart';

class DetailWidget extends StatefulWidget {

  final Aircraft _aircraft;

  DetailWidget(this._aircraft);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {

  final TextStyle _biggerFont = const TextStyle(fontSize: 30);

  @override
  Widget build(BuildContext context) {
    return new Padding(
            padding: new EdgeInsets.all(30.0),
            
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
             
            Text("Flight code: "+widget._aircraft.flightCode,style:  _biggerFont) ,

            Text("Airline: "+widget._aircraft.airline,style:  _biggerFont) ,
            
            Text("Aircraft type: "+widget._aircraft.aircraftType,style:  _biggerFont) ,
            
            Text("Terminal: "+widget._aircraft.terminal,style:  _biggerFont) ,
            
            Text("Gate: "+widget._aircraft.gate,style:  _biggerFont) ,
        
            FlatButton(
              onPressed: () {
                // setState(() => widget._aircrafts.add(Aircraft(tailNumberController.text,aircraftTypeController.text,airlineController.text,flightCodeController.text,terminalController.text,gateController.text))); 
                //Aircraft aircraft=Aircraft(tailNumberController.text,aircraftTypeController.text,airlineController.text,flightCodeController.text,terminalController.text,gateController.text);
                // widget._aircrafts.add(aircraft); 
                // widget.notifyParent();
                // Navigator.pop(context);
                _update(widget._aircraft); 
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

  void _update(Aircraft aircraft) async{
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