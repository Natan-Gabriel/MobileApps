
import 'dart:async';
import 'dart:math';
import 'dart:developer' as developer;
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
    try{
    final http.Response response = await http.post(
      new Uri.http(url, "/plane"),
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
    );
    developer.log("add of "+plane.toString()+" to the server returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
    return response.statusCode;
    }
    catch(exp){
      print(exp);
      developer.log("add of "+plane.toString()+" threw the following error: ",name: 'exam.server',
        error: exp);
      throw exp;
    }
  }

  static Future<int> update(Aircraft entity) async {
    // print("aircraft: "+aircraft.toString());
    try{
    final http.Response response = await http.put(
      new Uri.http(url, "/aircraft"+"/"+ entity.tailNumber),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body:  entity.toMap()
    );
    developer.log("update to "+entity.toString()+" returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
    return response.statusCode;
    } 
    catch(exp) {
      print(exp);
      developer.log("update to " + entity.toString()+" threw the following error: ",name: 'exam.server',
        error: exp);
      throw exp;

  }
  }

  static Future<int> delete(int id) async {
    // print("aircraft: "+aircraft.toString());
    try{
    final http.Response response = await http.delete(
      new Uri.http(url, "/plane"+"/"+ id.toString())
    );
    developer.log("delete of entity with id "+id.toString()+" returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
    return response.statusCode;
    }
    catch(exp){
      print(exp);
      developer.log("delete of plane with id "+id.toString() + "threw the following error: ",name: 'exam.server',
        error: exp);
      throw exp;
    }
      
  }




  // A method that retrieves all the dogs from the dogs table.
  static Future<List<Plane>> getAll() async {
    try{
      final response = await http.get(new Uri.http(url, '/all'));
      List<Plane> aircrafts = List<Plane>();

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        for(Map<String, dynamic> aircraft in jsonDecode(response.body)){
          print(aircraft['id']);
          //aircrafts.add(Plane.fromMap(aircraft));
          aircrafts.add(Plane(aircraft['id'], aircraft['name'], aircraft['status'], aircraft['size'], aircraft['owner'], aircraft['manufacturer'], aircraft['capacity']));
      }
      developer.log("getAll returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
      return aircrafts;
      }
    } catch(exp) {
        print(exp);
        developer.log("getAll threw the following error: ",name: 'exam.server',
          error: exp);
        throw(exp);
    }
  }


  static Future<List<Plane>> getAllOrdered() async {
    try{
    final response = await http.get(new Uri.http(url, '/all'));
    List<Plane> aircrafts = List<Plane>();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      for(Map<String, dynamic> aircraft in jsonDecode(response.body)){
        print(aircraft['id']);
        //aircrafts.add(Plane.fromMap(aircraft));
        aircrafts.add(Plane(aircraft['id'], aircraft['name'], aircraft['status'], aircraft['size'], aircraft['owner'], aircraft['manufacturer'], aircraft['capacity']));
      }
      aircrafts.sort((a, b) => a.size.compareTo(b.size));
      developer.log("getAllOrdered returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
      return aircrafts;
    } 
  }
  catch(exp) {
    print(exp);
    developer.log("getAllOrdered threw the following error: ",name: 'exam.server',
      error: exp);
    throw(exp);
  }
  }


  static Future<List<String>> getManufacturers() async {
    try{
      final response = await http.get(new Uri.http(url, '/types'));
      List<String> aircrafts = List<String>();

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        for(String aircraft in jsonDecode(response.body)){
          //print(aircraft['id']);
          //aircrafts.add(Plane.fromMap(aircraft));
          aircrafts.add(aircraft);
        }
        developer.log("getManufacturers returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
        return aircrafts;
      } 
    }
    catch(exp){
      print(exp);
      developer.log("getManufacturers threw the following error: ",name: 'exam.server',
        error: exp);
      throw(exp);
    }
     
  }

  static Future<List<Plane>> getAvailable(String manufacturer) async {
    try{
      final response = await http.get(new Uri.http(url, '/planes'+"/"+ manufacturer));
      List<Plane> aircrafts = List<Plane>();

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        for(Map<String, dynamic> aircraft in jsonDecode(response.body)){
          print(aircraft['id']);
          //if(manufacturer==aircraft['manufacturer'])
          //aircrafts.add(Plane.fromMap(aircraft));
          aircrafts.add(Plane(aircraft['id'], aircraft['name'], aircraft['status'], aircraft['size'], aircraft['owner'], aircraft['manufacturer'], aircraft['capacity']));
        }
        developer.log("getAvailable returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
        return aircrafts;
      } 
    }catch(exp) {
      print(exp);
      developer.log("getAvailable threw the following error: ",name: 'exam.server',
        error: exp);
      throw(exp);
  }
  }
  

}