import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import 'package:airport_manager/Aircraft.dart';


//how to see db in cmd:
//adb -s emulator-5554 shell
//run-as com.example.airport_manager
//cd /data/user/0/com.example.airport_manager/databases
//sqlite3 aircraft.db

 
 
class Db{

  static const _databaseName = 'aircraft.db';
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
          "CREATE TABLE aircrafts(tailNumber TEXT PRIMARY KEY, aircraftType TEXT, airline TEXT, flightCode TEXT , terminal TEXT, gate TEXT)",
        );  
  }

  

  Future<void> add(Aircraft aircraft) async {
    // Directory dataDirectory=await getApplicationDocumentsDirectory();
    // String dbPath = join(dataDirectory.path, _databaseName);
    // print('db location : '+dbPath);
    
    // Get a reference to the database.
    Database db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'aircrafts',
      aircraft.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
}


  // A method that retrieves all the dogs from the dogs table.
  Future<List<Aircraft>> getAll() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('aircrafts');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Aircraft(
        maps[i]['tailNumber'],
        maps[i]['aircraftType'],
        maps[i]['airline'],
        maps[i]['flightCode'],
        maps[i]['terminal'],
        maps[i]['gate'],
      );
    });
  }
  
  Future<void> update(Aircraft aircraft) async {
    // Get a reference to the database.
    Database db = await database;

    // Update the given Dog.
    await db.update(
      'aircrafts',
      aircraft.toMap(),
      // Ensure that the Dog has a matching id.
      where: "tailNumber = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [aircraft.tailNumber],
    );
  }

  Future<void> delete(String id) async {
  // Get a reference to the database.
    Database db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'aircrafts',
      // Use a `where` clause to delete a specific dog.
      where: "tailNumber = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

}