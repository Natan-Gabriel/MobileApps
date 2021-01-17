import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../domain/Book.dart';


class UpdateWidget extends StatefulWidget {


  @override
  _UpdateWidgetState createState() => _UpdateWidgetState();
}

class _UpdateWidgetState extends State<UpdateWidget> {

  final TextStyle _biggerFont = const TextStyle(fontSize: 18); // NEW

  // TextEditingController idController ;
  TextEditingController idController;// = TextEditingController();
  TextEditingController heightController;// = TextEditingController();



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

                  Text("id: ") ,

                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("Title",style:  _biggerFont) ),
                  Flexible(
                    child:  TextField(
                      controller: idController=TextEditingController(),          
                    ),
                  ),


                  
                  Padding(padding:new EdgeInsets.only(top: 10),child:Text("height",style:  _biggerFont) ),
                  Flexible(
                    child:  TextField(
                      controller: heightController=TextEditingController(),       
                    ),
                  ),

                  
                  

                  FlatButton(
                      onPressed: () {
                          List<int> l=List<int>();
                          l.add(int.parse(idController.text));
                          l.add(int.parse(heightController.text));

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