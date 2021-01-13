import 'package:flutter/material.dart';
import 'Aircraft.dart';
import 'UpdatePage.dart';
import 'domain/Plane.dart';

class DetailWidget extends StatelessWidget {

  final Plane _aircraft;

  DetailWidget(this._aircraft);

  final TextStyle _biggerFont = const TextStyle(fontSize: 30);

  @override
  Widget build(BuildContext context) {
    return new Padding(
            padding: new EdgeInsets.all(30.0),
            
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
   
            Text("Name: "+_aircraft.name,style:  _biggerFont) ,

            Text("Status: "+_aircraft.status,style:  _biggerFont) ,
            
            Text("Size: "+_aircraft.size.toString(),style:  _biggerFont) ,
            
            Text("Owner: "+_aircraft.owner,style:  _biggerFont) ,

            Text("Manufacturer: "+_aircraft.manufacturer,style:  _biggerFont) ,

            Text("Capacity: "+_aircraft.capacity.toString(),style:  _biggerFont) ,
        
            FlatButton(
              onPressed: () {

                //_update(_aircraft,context); 

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