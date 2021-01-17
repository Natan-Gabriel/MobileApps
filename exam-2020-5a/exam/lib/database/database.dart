import 'dart:io';

import 'package:airport_manager/domain/Book.dart';
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

  static const _databaseName = 'bookv4.db';
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
          "CREATE TABLE borrowed (id INTEGER PRIMARY KEY, title TEXT, status TEXT,student TEXT, pages INTEGER , usedCount INTEGER)"
        ); 
    await db.execute(
          "CREATE TABLE toAdd (id INTEGER PRIMARY KEY, title TEXT, status TEXT,student TEXT, pages INTEGER , usedCount INTEGER)"
        );  
    return await db.execute(
          "CREATE TABLE books(id INTEGER PRIMARY KEY, title TEXT, status TEXT,student TEXT, pages INTEGER , usedCount INTEGER)"
        );  
  }

  

  Future<void> add(Book entity) async {
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
        'books',
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

  Future<void> addToAdd(Book entity) async {
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
        'toAdd',
        entity.toLocalMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      developer.log("addToAdd: add of "+entity.toString()+" to the db was successful",name: 'exam.db');
    }
    catch(exp){
      print(exp);
      developer.log("addToAdd: add of "+entity.toString()+" threw the following error: ",name: 'exam.db',
        error: exp);
      throw exp;
    }
}

Future<void> addBorrowed(Book entity,{int online=0}) async {
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
      if(online==0){
        await db.insert(
          'borrowed',
          entity.toLocalMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      else{
        await db.insert(
          'borrowed',
          entity.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      developer.log("addBorrowed: add of "+entity.toString()+" to the db was successful",name: 'exam.db');
    }
    catch(exp){
      print(exp);
      developer.log("addBorrowed: add of "+entity.toString()+" threw the following error: ",name: 'exam.db',
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
        'books',
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

  Future<void> deleteToAdd(int id) async {

    try{
      Database db = await database;

      // Remove the Dog from the Database.
      await db.delete(
        'toAdd',
        // Use a `where` clause to delete a specific dog.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
      developer.log("deleteToAdd: entity having id "+id.toString()+" was successfully deleted",name: 'exam.db');
    }
    catch(exp){
      print(exp);
      developer.log("deleteToAdd: delete of plane with id "+id.toString() + "threw the following error: ",name: 'exam.db',
        error: exp);
      throw exp;
    }
  }

  

  Future<void> deleteBorrowed(int id) async {

    try{
      Database db = await database;

      // Remove the Dog from the Database.
      await db.delete(
        'borrowed',
        // Use a `where` clause to delete a specific dog.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
      developer.log("entity having id "+id.toString()+" was successfully deleted(deleteBorrowed)",name: 'exam.db');
    }
    catch(exp){
      print(exp);
      developer.log("deleteBorrowed plane with id "+id.toString() + "threw the following error: ",name: 'exam.db',
        error: exp);
      throw exp;
    }
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Book>> getAll() async {

    try{
      final Database db = await database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('books');

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

  

  Future<List<Book>> getAllBorrowed() async {

    try{
      final Database db = await database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('borrowed');

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
      developer.log("getAllBorrowed call to the db was successful",name: 'exam.db');
      return res;
    }
    catch(exp){
      print(exp);
      developer.log("getAllBorrowed threw the following error: ",name: 'exam.db',
        error: exp);
      throw(exp);
    }
  }

}