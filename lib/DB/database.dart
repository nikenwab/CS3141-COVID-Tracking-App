import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'location.dart';


class locationDBProvider {
  locationDBProvider._();
  static final locationDBProvider db = locationDBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'location.db'),
      onCreate:  (db, version) async{
        await db.execute('''
        CREATE TABLE location (
        id TEXT PRIMARY KEY, latitude DOUBLE, longitude DOUBLE, date TEXT 
        )
        ''');
      },
      version: 1
    );
  }

  newLocation(Location newLocation) async {
    final db = await database;

    var res = await db.rawInsert('''
    INSERT INTO location (
    id, latitude, longitude, date
    ) VALUES (?, ?, ?, ?)
    ''', [newLocation.id, newLocation.latitude, newLocation.longitude, newLocation.date]);
    return res;
  }

  Future<dynamic> getLocation() async {
    final db = await database;
    var res = await db.query("location");
    if(res.length == 0) {
      return null;
    } else {
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : Null;
    }
  }
}