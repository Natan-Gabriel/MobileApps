
import 'package:flutter/material.dart';
import 'Aircraft.dart';

class DeletePage extends StatelessWidget {


  final List<Aircraft> _aircrafts;

  DeletePage(this._aircrafts);


//   @override
//   _DeletePageState createState() => _DeletePageState();
// }

// class _DeletePageState extends State<DeletePage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('NO'),
            onPressed: () {
              Navigator.pop(context,'NO');
            },
          ),
          TextButton(
            child: Text('YES'),
            onPressed: () {
              Navigator.pop(context,'YES');
            },
          ),
        ],
      );
  }
}