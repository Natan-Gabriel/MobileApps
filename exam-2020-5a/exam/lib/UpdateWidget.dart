import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'domain/Book.dart';


class UpdateWidget extends StatefulWidget {

  final Book _entity;

  UpdateWidget(this._entity);

  @override
  _UpdateWidgetState createState() => _UpdateWidgetState();
}

class _UpdateWidgetState extends State<UpdateWidget> {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  // TextEditingController idController ;//= TextEditingController(text: widget._aircraft.flightCode);
  TextEditingController titleController;// = TextEditingController();
  TextEditingController statusController;// = TextEditingController();
  TextEditingController studentController;// = TextEditingController();
  TextEditingController pagesController;// = TextEditingController();
  TextEditingController usedCountController;// = TextEditingController();
  


  @override
  Widget build(BuildContext context) {
    return Scaffold (                    
      appBar: AppBar(
        title: Text('Update a book'),
      ),
      body: new Padding(
            padding: new EdgeInsets.all(30.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[  

                  Text("id: "+widget._entity.id.toString(),style:  _biggerFont) ,

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Title",style:  _biggerFont) ),
                  // Text("Aircraft type",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: titleController=TextEditingController(text: widget._entity.title),          
                    ),
                  ),


                  
                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Status",style:  _biggerFont) ),
                  // Text("Airline",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: statusController=TextEditingController(text: widget._entity.status),       
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Student",style:  _biggerFont) ),
                  // Text("Flight code",style:  _biggerFont) ,
                  
                  Flexible(
                    child:  TextField(
                      controller: studentController=TextEditingController(text: widget._entity.student),
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Pages",style:  _biggerFont) ),
                  // Text("Terminal",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: pagesController=TextEditingController(text: widget._entity.pages.toString()),          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("usedCount",style:  _biggerFont) ),
                  // Text("Gate",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: usedCountController=TextEditingController(text: widget._entity.usedCount.toString()),          
                    ),
                  ),

                  FlatButton(
                      onPressed: () {
                          Book entity=Book(widget._entity.id,titleController.text,statusController.text,studentController.text,int.parse(pagesController.text),int.parse(usedCountController.text));
                          
                          Navigator.pop(context,entity);
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