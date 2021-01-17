
import 'package:airport_manager/domain/Robot.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../domain/Book.dart';



class UpdateWidget2 extends StatefulWidget {

  final Robot _entity;

  UpdateWidget2(this._entity);

  @override
  _UpdateWidget2State createState() => _UpdateWidget2State();
}

class _UpdateWidget2State extends State<UpdateWidget2> {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  // TextEditingController idController ;
  TextEditingController ageController;// = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold (                    
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: new Padding(
            padding: new EdgeInsets.all(30.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[  

                  Text("id: "+widget._entity.id.toString(),style:  _biggerFont) ,

                 Padding(padding:new EdgeInsets.only(top: 10),child:Text("height",style:  _biggerFont) ),
                  Flexible(
                    child:  TextField(
                      controller: ageController=TextEditingController(),       
                    ),
                  ),

                  
                

                  FlatButton(
                      onPressed: () {
                          int l;
                         
                          l=int.parse(ageController.text);

                          Navigator.pop(context,l);
                          },
                      child: Text(
                        "Update",
                      ),
                      color: Colors.green,
                  )
          
            ])
      )
    );
  }
}