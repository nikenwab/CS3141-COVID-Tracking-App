import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'location.dart';

//This file takes an instance of location to be stored locally on the device
//This is our db manager that creates/updates map values
class locationDB {
  Database _database;
//Creates a location.db file if one does not already exist
  Future openDB() async {
    if(_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "location.db"),
          version: 1,
          onCreate: (Database db, int version) async {
            await db.execute(
                "CREATE TABLE location (id INTEGER PRIMARY KEY autoincrement, latitude DOUBLE, longitude DOUBLE, date TEXT)");
          });
    }
  }
//Insert location method
  Future<int> insertLocation(Location location) async {
    await openDB();
    return await _database.insert('location', location.toJson());
  }
//Returns location values as a list
  Future<List<Location>> getLocationList() async {
    await openDB();
    final List<Map<String, dynamic>> maps = await _database.query('location');
    return List.generate(maps.length, (i) {
      return Location(
        id: maps[i]['id'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
        date: maps[i]['date'],
      );
    });
  }
//Updates a table index of the database
  Future<int> updateLocation(Location location) async {
    await openDB();
    return await _database.update('location', location.toJson(), where: "id = ?", whereArgs: [location.id]);
  }
//Removes a location from the DB
  Future<void> deleteLocation(Location location) async {
    await openDB();
    await _database.delete(
        'location', where: "id = ?", whereArgs: [location.id]);
  }
}