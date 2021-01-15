import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import 'package:airport_manager/Aircraft.dart';
import 'package:airport_manager/domain/Plane.dart';

//how to see db in cmd:
//adb -s emulator-5554 shell
//run-as com.example.airport_manager
//cd /data/user/0/com.example.airport_manager/databases
//sqlite3 aircraft.db

 
 
class Db{

  static const _databaseName = 'plane.db';
  static const _databaseVersion = 1;

  Db._();
  static final Db instance = Db._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String dbPath = join(await getDatabasesPath(), _databaseName);
    print("dbPath: "+dbPath);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    //create tables
    return await db.execute(
          "CREATE TABLE planes(id INTEGER PRIMARY KEY, name TEXT, status TEXT, size INTEGER , owner TEXT, manufacturer TEXT, capacity INTEGER)",
        );  
  }

  

  Future<void> add(Plane plane) async {
    // Directory dataDirectory=await getApplicationDocumentsDirectory();
    // String dbPath = join(dataDirectory.path, _databaseName);
    // print('db location : '+dbPath);
    
    // Get a reference to the database.
    try{
      Database db = await database;

      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert(
        'planes',
        plane.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      developer.log("add of "+plane.toString()+" to the db was successful",name: 'exam.db');
    }
    catch(exp){
      print(exp);
      developer.log("add of "+plane.toString()+" threw the following error: ",name: 'exam.db',
        error: exp);
      throw exp;
    }
}
  
  Future<void> update(Aircraft entity) async {


    try{
      Database db = await database;

      // Update the given Dog.
      await db.update(
        'aircrafts',
        entity.toMap(),
        // Ensure that the Dog has a matching id.
        where: "tailNumber = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [entity.tailNumber],
      );
      developer.log("update to "+entity.toString()+" in the db was successful",name: 'exam.db');

    }
    catch(exp){
      print(exp);
      developer.log("update to " + entity.toString()+" threw the following error: ",name: 'exam.db',
        error: exp);
      throw exp;
    }
  }

  Future<void> delete(int id) async {

    try{
      Database db = await database;

      // Remove the Dog from the Database.
      await db.delete(
        'planes',
        // Use a `where` clause to delete a specific dog.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
      developer.log("entity having id "+id.toString()+" was successfully deleted",name: 'exam.db');
    }
    catch(exp){
      print(exp);
      developer.log("delete of plane with id "+id.toString() + "threw the following error: ",name: 'exam.db',
        error: exp);
      throw exp;
    }
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Plane>> getAll() async {

    try{
      final Database db = await database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('planes');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      List<Plane> res=List.generate(maps.length, (i) {
        return Plane(
          maps[i]['id'],
          maps[i]['name'],
          maps[i]['status'],
          maps[i]['size'],
          maps[i]['owner'],
          maps[i]['manufacturer'],
          maps[i]['capacity'],
        );
      });
      developer.log("getAll call to the db was successful",name: 'exam.db');
      return res;
    }
    catch(exp){
      print(exp);
      developer.log("getAll threw the following error: ",name: 'exam.db',
        error: exp);
      throw(exp);
    }
  }

}