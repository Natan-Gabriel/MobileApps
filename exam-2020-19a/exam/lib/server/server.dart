
import 'dart:async';
import 'dart:math';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import 'package:airport_manager/Aircraft.dart';
import 'package:airport_manager/domain/Plane.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Server{

  static const String url='10.0.2.2:1876';
  
  static Server _instance;
  factory Server() => _instance ??= new Server._();

  Server._();

  static Future<int> add(Plane plane) async {
    // print("aircraft: "+aircraft.toString());
    try{
    final http.Response response = await http.post(
      new Uri.http(url, "/plane"),
      // headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      //body: plane.toMap(),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode(plane.toMap()),
    //   body: json.encode(<String, dynamic>{
    //   "id": 93,
    //   "name": "93",
    //   "status": "93",
    //   "size": 93,
    //   "owner": "93",
    //   "manufacturer": "93",
    //   "capacity": 93,
      
    // }) ,
    //headers:{"content-type":"application/json"}
    );
    return response.statusCode;
    }
    catch(exp){
      // print("plane.toMap():");
      // print(plane.toMap());
      print(exp);
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
      print(e);
        return -1;
    }
      
  }


  // A method that retrieves all the dogs from the dogs table.
  static Future<List<Plane>> getAll() async {

    final response = await http.get(new Uri.http(url, '/all'));
    List<Plane> aircrafts = List<Plane>();

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    for(Map<String, dynamic> aircraft in jsonDecode(response.body)){
      print(aircraft['id']);
      aircrafts.add(Plane.fromMap(aircraft));
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