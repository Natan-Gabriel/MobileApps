

import 'package:flutter/material.dart';

class SetNameWidget extends StatelessWidget {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  final nameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold (                    
      appBar: AppBar(
        title: Text('set name'),
      ),
      body: new Padding(
            padding: const EdgeInsets.all(30.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[  

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Name",style:  _biggerFont) ),
                  // Text("Tail number",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: nameController,          
                    ),
                  ),
                  
            

                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context,nameController.text);
                                  
                    
                      //Navigator.pop(context);//
                    },
                    child: Text(
                      "Submit",),
                    color: Colors.green,
                  )
              
            ])
           
            )
    );
  }
}