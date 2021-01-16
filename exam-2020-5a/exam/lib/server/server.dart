
import 'dart:async';
import 'dart:math';
import 'dart:developer' as developer;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import 'package:airport_manager/domain/Book.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


class Server{

  static const String url='10.0.2.2:2501';
  
  static Server _instance;
  factory Server() => _instance ??= new Server._();

  Server._();

  static Future<int> add(Book entity) async {
    try{
    final http.Response response = await http.post(
      new Uri.http(url, "/book"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    body: json.encode(entity.toMap()),
    //   body: json.encode(<String, dynamic>{
    //   "id": 93,
    //   "name": "93",
    //   "status": "93",
    //   "size": 93,
    //   "owner": "93",
    //   "manufacturer": "93",
    //   "capacity": 93,
    );
    developer.log("add of "+entity.toString()+" to the server returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
    return response.statusCode;
    }
    catch(exp){
      print(exp);
      developer.log("add of "+entity.toString()+" threw the following error: ",name: 'exam.server',
        error: exp);
      throw exp;
    }
  }

  static Future<int> borrow(int id,String student) async {
      try{
      final http.Response response = await http.post(
        new Uri.http(url, "/borrow"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      // body: json.encode(entity.toMap()),
        body: json.encode(<String, dynamic>{
        "id": id,
        "student": student,
        })

      );
      developer.log("borrow of book with id "+id.toString()+" returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
      return response.statusCode;
      }
      catch(exp){
        print(exp);
        developer.log("borrow of book with id "+id.toString()+" threw the following error: ",name: 'exam.server',
          error: exp);
        throw exp;
      }
    }


  // static Future<int> update(Book entity) async {
  //   // print("aircraft: "+aircraft.toString());
  //   try{
  //   final http.Response response = await http.put(
  //     new Uri.http(url, "/aircraft"+"/"+ entity.id),
  //     // headers: <String, String>{
  //     //   'Content-Type': 'application/json; charset=UTF-8',
  //     // },
  //     body:  entity.toMap()
  //   );
  //   developer.log("update to "+entity.toString()+" returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
  //   return response.statusCode;
  //   } 
  //   catch(exp) {
  //     print(exp);
  //     developer.log("update to " + entity.toString()+" threw the following error: ",name: 'exam.server',
  //       error: exp);
  //     throw exp;

  // }
  // }

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

  static Future<List<Book>> getAll() async {
    try{
      final response = await http.get(new Uri.http(url, '/all'));
      List<Book> entities = List<Book>();

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        for(Map<String, dynamic> aircraft in jsonDecode(response.body)){
          print(aircraft['id']);
          //aircrafts.add(Plane.fromMap(aircraft));
          entities.add(Book(aircraft['id'], aircraft['title'], aircraft['status'], aircraft['student'], aircraft['pages'], aircraft['usedCount']));
      }
      //entities.sort((a, b) => a.size.compareTo(b.size));
      developer.log("getAll returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
      return entities;
      }
    } catch(exp) {
        print(exp);
        developer.log("getAll threw the following error: ",name: 'exam.server',
          error: exp);
        throw(exp);
    }
  }

  static Future<List<Book>> getTop() async {
    try{
      final response = await http.get(new Uri.http(url, '/all'));
      List<Book> entities = List<Book>();

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        for(Map<String, dynamic> aircraft in jsonDecode(response.body)){
          print(aircraft['id']);
          //aircrafts.add(Plane.fromMap(aircraft));
          entities.add(Book(aircraft['id'], aircraft['title'], aircraft['status'], aircraft['student'], aircraft['pages'], aircraft['usedCount']));
      }
      entities.sort((a, b) => b.usedCount.compareTo(a.usedCount));
      List<Book> res=List<Book>();
      for(int i=0;i<10;i++){
        res.add(entities[i]);
      }
      developer.log("getAll returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
      return res;
      }
    } catch(exp) {
        print(exp);
        developer.log("getAll threw the following error: ",name: 'exam.server',
          error: exp);
        throw(exp);
    }
  }

  static Future<List<Book>> getAllBorrowed(String student) async {
    try{
      final response = await http.get(new Uri.http(url, '/books'+"/"+ student));
      List<Book> entities = List<Book>();

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        for(Map<String, dynamic> aircraft in jsonDecode(response.body)){
          print(aircraft['id']);
          //aircrafts.add(Plane.fromMap(aircraft));
          entities.add(Book(aircraft['id'], aircraft['title'], aircraft['status'], aircraft['student'], aircraft['pages'], aircraft['usedCount']));
      }
      developer.log("getAll returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
      return entities;
      }
    } catch(exp) {
        print(exp);
        developer.log("getAll threw the following error: ",name: 'exam.server',
          error: exp);
        throw(exp);
    }
  }


  static Future<List<Book>> getAvailable() async {
    try{
      final response = await http.get(new Uri.http(url, '/available'));
      List<Book> entities = List<Book>();

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        for(Map<String, dynamic> aircraft in jsonDecode(response.body)){
          print(aircraft['id']);
          //if(manufacturer==aircraft['manufacturer'])
          //aircrafts.add(Plane.fromMap(aircraft));
          entities.add(Book(aircraft['id'], aircraft['title'], aircraft['status'], aircraft['student'], aircraft['pages'], aircraft['usedCount']));
      }
        developer.log("getAvailable returned the status code "+response.statusCode.toString()+" and the body "+response.body.toString(),name: 'exam.server');
        return entities;
      } 
    }catch(exp) {
      print(exp);
      developer.log("getAvailable threw the following error: ",name: 'exam.server',
        error: exp);
      throw(exp);
  }
  }
  

}