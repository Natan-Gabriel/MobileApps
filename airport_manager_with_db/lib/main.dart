import 'package:airport_manager/size_config/size_config.dart';
import 'package:flutter/material.dart';
import 'ListAircraft.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airport Manager',
      theme: ThemeData(         
        primaryColor: Colors.green,
      ),                       
      home: ListAircraft(),
    );
  }
}



class Testing extends StatefulWidget {
  Testing({Key key}) : super(key: key);

  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<Testing> {

  

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("DataTable"),
      ),
      body: Row(
        children: <Widget>[
          //TODO: use Expanded here
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(0.0),
              child: DataTable(
                columnSpacing: 0,
                columns: [
                  DataColumn(
                    label: 
                    // label: Text('Item Code'),
                     Container(
                      width: SizeConfig.blockSizeHorizontal * 50,
                      child: Text('ItemCodeaaaaaaaaaaaaaaaaaaaaaaaaagggggggg'),
                    ),
                  ),
                  DataColumn(
                    // label: Text('Stock Item'),
                    label: Container(
                      width: SizeConfig.blockSizeHorizontal * 50,
                      child: Text('Stock Item'),
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(
                        //Text('Yup.  text.'),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 40,
                        child:Text(
                          'Yup.  text.'),
                            //'This is a really long text. It\'s supposed to be long so that I can figure out what in the hell is happening to the ability to have the text wrap in this datacell.  So far, I haven\'t been able to figure it out.'),
                      )
                      ),
                      DataCell(
                        // Container(
                        //   width: SizeConfig.blockSizeHorizontal * 40,
                        // child:Text(
                        //   'Thissareallylongtext.It\'ssupposedtobelongsothat I can figure out what in the hell is happening to the ability to have the text wrap in this datacell.  So far, I haven\'t been able to figure it out.'),
                           customContainer( 'This is a really long text. It\'s supposed to be long so that I can figure out what in the hell is happening to the ability to have the text wrap in this datacell.  So far, I haven\'t been able to figure it out.'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget customContainer(String str){
    return Container(
      width: SizeConfig.blockSizeHorizontal * 30,
      child: Text(str),
    );
  }
}