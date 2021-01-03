
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import 'package:airport_manager/Aircraft.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Server{

  static const String url='10.0.2.2:8000';


  // Server._();
  // static final Server instance = Server._();

  // Server._();
  // static final Server instance = Server._();

  // Server _server;

  
  static Server _instance;
  factory Server() => _instance ??= new Server._();

  Server._();


  // Server._();

  // static final Server _instance = Server._();

  // static Server get instance => _instance;

  // static Server _instance;

  // Server._internal() {
  //   _instance = this;
  // }

  // factory Server() => _instance ?? Server._internal();

  // Database _database;
  // Future<Database> get database async {
  //   if (_database != null) return _database;
  //   // _database = await _initDatabase();
  //   return _database;
  // }

  // Future<http.Response> isOnline() {
  //   return http.get('https://jsonplaceholder.typicode.com/albums/1');
  // }

  // _initDatabase() async {
  //   String dbPath = join(await getDatabasesPath(), _databaseName);
  //   print("dbPath: "+dbPath);
  //   return await openDatabase(dbPath,
  //       version: _databaseVersion, onCreate: _onCreateDB);
  // }

  // Future _onCreateDB(Database db, int version) async {
  //   //create tables
  //   return await db.execute(
  //         "CREATE TABLE aircrafts(tailNumber TEXT PRIMARY KEY, aircraftType TEXT, airline TEXT, flightCode TEXT , terminal TEXT, gate TEXT)",
  //       );  
  // }

  
  static Future<int> add(Aircraft aircraft) async {
    // print("aircraft: "+aircraft.toString());
    try{
    final http.Response response = await http.post(
      new Uri.http(url, "/aircraft"),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body:  aircraft.toMap()
    );
    return response.statusCode;
    }
    catch(Exception){
        return -1;
    }
  }

  static Future<int> update(Aircraft aircraft) async {
    // print("aircraft: "+aircraft.toString());
    try{
    final http.Response response = await http.put(
      new Uri.http(url, "/aircraft"+"/"+ aircraft.tailNumber),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body:  aircraft.toMap()
    );
    return response.statusCode;
    } 
    catch(Exception) {
      // If the server did not return a 200 response,
      // then throw an exception.
      return -1;
  }
  }

  static Future<int> delete(String id) async {
    // print("aircraft: "+aircraft.toString());
    try{
    final http.Response response = await http.delete(
      new Uri.http(url, "/aircraft"+"/"+ id)
    );
    return response.statusCode;
    }
    catch(Exception){
        return -1;
    }
      
  }


  // A method that retrieves all the dogs from the dogs table.
  static Future<List<Aircraft>> getAll() async {

    final response = await http.get(new Uri.http(url, '/aircrafts'));
    List<Aircraft> aircrafts = List<Aircraft>();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    for(Map<String, dynamic> aircraft in jsonDecode(response.body)){
      aircrafts.add(Aircraft(aircraft['tailNumber'], aircraft['aircraftType'], aircraft['airline'], aircraft['flightCode'], aircraft['terminal'], aircraft['gate']));
    }
    return aircrafts;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  }
  
  // Future<void> update(Aircraft aircraft) async {
  //   // Get a reference to the database.
  //   Database db = await database;

  //   // Update the given Dog.
  //   await db.update(
  //     'aircrafts',
  //     aircraft.toMap(),
  //     // Ensure that the Dog has a matching id.
  //     where: "tailNumber = ?",
  //     // Pass the Dog's id as a whereArg to prevent SQL injection.
  //     whereArgs: [aircraft.tailNumber],
  //   );
  // }

  // Future<void> delete(String id) async {
  // // Get a reference to the database.
  //   Database db = await database;

  //   // Remove the Dog from the Database.
  //   await db.delete(
  //     'aircrafts',
  //     // Use a `where` clause to delete a specific dog.
  //     where: "tailNumber = ?",
  //     // Pass the Dog's id as a whereArg to prevent SQL injection.
  //     whereArgs: [id],
  //   );
  // }

}