
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import 'package:airport_manager/Aircraft.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Server{

  final String url='10.0.2.2:8000';


  Server._();
  static final Server instance = Server._();

  // Database _database;
  // Future<Database> get database async {
  //   if (_database != null) return _database;
  //   // _database = await _initDatabase();
  //   return _database;
  // }

  Future<http.Response> isOnline() {
    return http.get('https://jsonplaceholder.typicode.com/albums/1');
  }

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

  

  Future<void> add(Aircraft aircraft) async {
    print("aircraft: "+aircraft.toString());
    return http.post(
      new Uri.http(url, "/aircraft"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:  jsonEncode(aircraft.toMap())
    );
  }


  // A method that retrieves all the dogs from the dogs table.
  Future<Aircraft> getAll() async {

    final response = await http.get(url+'/aircraft/'+"1");

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Aircraft.fromJson(jsonDecode(response.body));
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