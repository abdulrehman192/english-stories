import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class SqliteService
{
  Database? _db;
  static const _dbName = "stories.db";

  //private constructor to avoid read-only status of database

  SqliteService._privateConstructor();
  static final SqliteService instance = SqliteService._privateConstructor();

  Future<Database> get db async
  {
    _db ??= await initDB();
    return _db!;
  }

  initDB() async
  {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    File file = File(path);
    if(file.existsSync())
    {
      return await openDatabase(path);
    }
    else
    {
      await copyDatabase();
      return await openDatabase(path);
    }

  }


  Future<int> insert(String query) async
  {
    Database database = await db;
    int id = await database.rawInsert(query);
    return id;
  }

  Future<int> update(String query) async
  {
    Database database = await db;
    int id = await database.rawUpdate(query);
    return id;
  }

  Future<int> delete(String query) async
  {
    Database database = await db;
    int id = await database.rawDelete(query);
    return id;
  }

  Future<List<Map<String, dynamic>>> getAllRows(String query) async
  {
    Database database = await db;
    var result = await database.rawQuery(query);
    return result;
  }

  Future<bool> checkIfDatabaseExist() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    bool exists = false;
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.file)
    {
      exists = true;
    }
    return exists;
  }

  Future<bool> copyDatabase() async
  {
    bool done = false;

    // Copy from asset
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
      print("DB Not Found");
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets/database', 'stories.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await File(path).writeAsBytes(bytes);
      done = true;
    }
    else
    {
      done = true;
    }
    return done;
  }
}