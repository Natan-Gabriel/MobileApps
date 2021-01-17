import 'package:flutter/material.dart';
import 'UpdateWidget.dart';
import '../domain/Book.dart';

class DetailWidget extends StatelessWidget {

  final Book _entity;

  DetailWidget(this._entity);

  final TextStyle _biggerFont = const TextStyle(fontSize: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold (                    
      appBar: AppBar(
        title: Text('Book detail'),
      ),
      body: new Padding(
            padding: new EdgeInsets.all(30.0),
            
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
   
            Text("id: "+_entity.id.toString(),style:  _biggerFont) ,

            Text("title: "+_entity.title,style:  _biggerFont) ,
            
            Text("status: "+_entity.status.toString(),style:  _biggerFont) ,
            
            Text("student: "+_entity.student,style:  _biggerFont) ,

            Text("pages: "+_entity.pages.toString(),style:  _biggerFont) ,

            Text("usedCount: "+_entity.usedCount.toString(),style:  _biggerFont) ,
        
            FlatButton(
              onPressed: () {

                _update(_entity,context); 

              },
              child: Text(
                "Update",
                style: _biggerFont,
                
              ),
              color: Colors.blue,
            )
          
            ])
      )
    );
  }

  void _update(Book entity,BuildContext context) async{
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the AddPage Screen.
    final Book result=await Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     UpdateWidget(entity)
                  
                ));
    if(result!=null){//somehow optional
      Navigator.pop(context,result);
    }
  }


}