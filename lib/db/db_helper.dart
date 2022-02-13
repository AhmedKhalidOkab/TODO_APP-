// ignore_for_file: unused_field, unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'tasks';
  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint('Valid DataBase');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'task.db';
        debugPrint('in DataBase path');
        var _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int _version) async {
          debugPrint('Creating a new one');

          // When creating the db, create the table
          await db.execute('CREATE TABLE _tableName('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'title STRING, note STRING,isCompleted INTEGER,'
              'date STRING,startTime STRING,endTime STRING ,'
              ' color INTEGER ,remind INTEGER ,repeat STRING )');
        });
      } catch (e) {
        print(e);
      }
    }
  }

  //*create new database

  static Future<int> insert(Task? task) async {
    print('INSERT');
    try {
      return await _db!.insert(_tableName, task!.tojson());
    } catch (e) {
      return 9000;
    }
  }

  static Future<int> delete(Task task) async {
    print('DELETE');
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static Future<List<Map<String, Object?>>> query() async {
    print('query');
    return await _db!.query(_tableName);
  }

  static Future<int> update(int id) async {
    print('Update');
    return await _db!.rawUpdate('''
       
       UPDATE tasks 
       SET isCompleted=? 
       WHERE id=?  
       //TODO: 1 TO isCompleted first '?' 
       //TODO: ID TO id second '?'
     ''', [1, id]);
  }
}
