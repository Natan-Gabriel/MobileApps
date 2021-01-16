


import 'package:flutter/material.dart';
import '../domain/Book.dart';


class BorrowWidget extends StatelessWidget {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  final idController = TextEditingController();
  final studentController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold (                    
      appBar: AppBar(
        title: Text('Borrow book'),
      ),
      body: new Padding(
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
                  
                 
                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Student",style:  _biggerFont) ),
                  // Text("Terminal",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: studentController,          
                    ),
                  ),

                  


                  FlatButton(
                    onPressed: () {
                      List<String> l=[idController.text,studentController.text];
                      Navigator.pop(context,l);
                        
                    },
                    child: Text(
                      "Borrow",),
                    color: Colors.green,
                  )
              
            ])
           
            )
    );
  }
}