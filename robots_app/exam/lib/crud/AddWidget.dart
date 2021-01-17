import 'package:airport_manager/domain/Robot.dart';
import 'package:flutter/material.dart';
import '../domain/Book.dart';


class AddWidget extends StatelessWidget {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final specsController = TextEditingController();

  final heightController = TextEditingController();
  final typeController = TextEditingController();
  final ageController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold (                    
      appBar: AppBar(
        title: Text('Add a book'),
      ),
      body: Padding(
            padding: const EdgeInsets.all(30.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[  

                  // Padding(padding:new EdgeInsets.only(top: 10),child:Text("Id",style:  _biggerFont) ),
                  // // Text("Tail number",style:  _biggerFont) ,
                  // Flexible(
                  //   child:  TextField(
                  //     controller: idController,          
                  //   ),
                  // ),
                  
                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Name",style:  _biggerFont) ),
                  Flexible(
                    child:  TextField(
                      controller: nameController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Specs",style:  _biggerFont) ),
                  Flexible(
                    child:  TextField(
                      controller: specsController,          
                    ),
                  ),

                  Text("Height",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: heightController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Type",style:  _biggerFont) ),
                  // Text("Terminal",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: typeController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Age",style:  _biggerFont) ),
                  // Text("Terminal",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: ageController,          
                    ),
                  ),

                  


                  FlatButton(
                    onPressed: () {

                      Robot entity=Robot(0,nameController.text,specsController.text,int.parse(heightController.text),typeController.text,int.parse(ageController.text));
                      Navigator.pop(context,entity);

                    },
                    child: Text("Add"),
                    color: Colors.green,
                  )
              
            ])
      )
    );
  }
}