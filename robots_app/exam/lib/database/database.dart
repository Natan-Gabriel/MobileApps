import 'dart:io';

import 'package:airport_manager/domain/Book.dart';
import 'package:airport_manager/domain/Robot.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';



//how to see db in cmd:
//adb -s emulator-5554 shell
//run-as com.example.airport_manager
//cd /data/user/0/com.example.airport_manager/databases
//sqlite3 aircraft.db

 
 
class Db{

  static const _databaseName = 'robotv1.db';
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
    await db.execute(
          "CREATE TABLE types (type TEXT)"
        ); 
    // await db.execute(
    //       "CREATE TABLE toAdd (id INTEGER PRIMARY KEY, title TEXT, status TEXT,student TEXT, pages INTEGER , usedCount INTEGER)"
    //     );  
    return await db.execute(
          "CREATE TABLE robots(id INTEGER PRIMARY KEY, name TEXT, specs TEXT,height INTEGER, type TEXT , age INTEGER)"
        );  
  }

  

  Future<void> add(Robot entity) async {
    try{
      Database db = await database;

      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert(
        'robots',
        entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      developer.log("add: add of "+entity.toString()+" to the db was successful",name: 'exam.db');
    }
    catch(exp){
      print(exp);
      developer.log("add: add of "+entity.toString()+" threw the following error: ",name: 'exam.db',
        error: exp);
      throw exp;
    }
}

  Future<void> addType(String type) async {
    try{
      Database db = await database;

      await db.insert(
        'types',
        {
          "type":type
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      developer.log("addToAdd: add of "+type.toString()+" to the db was successful",name: 'exam.db');
    }
    catch(exp){
      print(exp);
      developer.log("addToAdd: add of "+type.toString()+" threw the following error: ",name: 'exam.db',
        error: exp);
      throw exp;
    }
}



  
  Future<void> update(Book entity) async {


    try{
      Database db = await database;

      // Update the given Dog.
      await db.update(
        'books',
        entity.toMap(),
        // Ensure that the Dog has a matching id.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [entity.id],
      );
      developer.log("update: update to "+entity.toString()+" in the db was successful",name: 'exam.db');

    }
    catch(exp){
      print(exp);
      developer.log("update: update to " + entity.toString()+" threw the following error: ",name: 'exam.db',
        error: exp);
      throw exp;
    }
  }
  Future<void> delete(int id) async {

    try{
      Database db = await database;

      // Remove the Dog from the Database.
      await db.delete(
        'robots',
        // Use a `where` clause to delete a specific dog.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
      developer.log("delete: entity having id "+id.toString()+" was successfully deleted",name: 'exam.db');
    }
    catch(exp){
      print(exp);
      developer.log("delete: delete of plane with id "+id.toString() + "threw the following error: ",name: 'exam.db',
        error: exp);
      throw exp;
    }
  }

  Future<void> deleteType(String type) async {

    try{
      Database db = await database;

      // Remove the Dog from the Database.
      await db.delete(
        'types',
        // Use a `where` clause to delete a specific dog.
        where: "type = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [type],
      );
      developer.log("deleteType: entity having type "+type.toString()+" was successfully deleted",name: 'exam.db');
    }
    catch(exp){
      print(exp);
      developer.log("deleteType: delete of entity with type "+type.toString() + "threw the following error: ",name: 'exam.db',
        error: exp);
      throw exp;
    }
  }

  

 

  // A method that retrieves all the dogs from the dogs table.
  Future<List<String>> getTypes() async {

    try{
      final Database db = await database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('types');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      List<String> res=List.generate(maps.length, (i) {
        return maps[i]['type'];
      });
      developer.log("getTypes call to the db was successful and returned: "+res.toString(),name: 'exam.db');
      return res;
    }
    catch(exp){
      print(exp);
      developer.log("getTypes threw the following error: ",name: 'exam.db',
        error: exp);
      throw(exp);
    }
  }

  Future<List<Robot>> getAll(String _type) async {

    try{
      final Database db = await database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('robots',
      where: "type = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [_type],);

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      List<Robot> res=List.generate(maps.length, (i) {
        return Robot(
          maps[i]['id'],
          maps[i]['name'],
          maps[i]['specs'],
          maps[i]['height'],
          maps[i]['type'],
          maps[i]['age']
        );
      });
      developer.log("getAll call to the db was successful and returned: "+res.toString(),name: 'exam.db');
      return res;
    }
    catch(exp){
      print(exp);
      developer.log("getAll threw the following error: ",name: 'exam.db',
        error: exp);
      throw(exp);
    }
  }


  Future<List<Book>> getAllToAdd() async {

    try{
      final Database db = await database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('toAdd');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      List<Book> res=List.generate(maps.length, (i) {
        return Book(
          maps[i]['id'],
          maps[i]['title'],
          maps[i]['status'],
          maps[i]['student'],
          maps[i]['pages'],
          maps[i]['usedCount']
        );
      });
      print("getAllToAdd returned: "+res.toString());
      developer.log("getAllToAdd call to the db was successful",name: 'exam.db');
      return res;
    }
    catch(exp){
      print(exp);
      developer.log("getAllToAdd threw the following error: ",name: 'exam.db',
        error: exp);
      throw(exp);
    }
  }


}