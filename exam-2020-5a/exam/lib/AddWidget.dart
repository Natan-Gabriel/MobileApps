import 'package:flutter/material.dart';
import 'domain/Book.dart';


class AddWidget extends StatelessWidget {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  final idController = TextEditingController();
  final titleController = TextEditingController();
  final statusController = TextEditingController();

  final pagesController = TextEditingController();
  final usedCountController = TextEditingController();



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

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Id",style:  _biggerFont) ),
                  // Text("Tail number",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: idController,          
                    ),
                  ),
                  
                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Title",style:  _biggerFont) ),
                  // Text("Aircraft type",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: titleController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Status",style:  _biggerFont) ),
                  // Text("Airline",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: statusController,          
                    ),
                  ),

                  Text("pages",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: pagesController,          
                    ),
                  ),

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("used Count",style:  _biggerFont) ),
                  // Text("Terminal",style:  _biggerFont) ,
                  Flexible(
                    child:  TextField(
                      controller: usedCountController,          
                    ),
                  ),

                  


                  FlatButton(
                    onPressed: () {

                      Book entity=Book(int.parse(idController.text),titleController.text,statusController.text,"",int.parse(pagesController.text),int.parse(usedCountController.text));
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