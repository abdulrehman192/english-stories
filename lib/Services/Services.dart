import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  Database? _db;
  static const _dbName = "stories.db";
  static const _dbAssetPath = "assets/database/stories.db";

  SqliteService._privateConstructor();
  static final SqliteService instance = SqliteService._privateConstructor();

  Future<Database> get db async {
    _db ??= await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(documentsDirectory.path, _dbName);

    if (!await File(dbPath).exists()) {
      await _copyDatabaseFromAssets(dbPath);
    }

    return await openDatabase(dbPath,);
  }

  Future<void> _copyDatabaseFromAssets(String destinationPath) async {
    try {
      ByteData data = await rootBundle.load(_dbAssetPath);
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(destinationPath).writeAsBytes(bytes, flush: true);
      print("Database copied from assets.");
    } catch (e) {
      print("Error copying database: $e");
      rethrow;
    }
  }

  Future<int> insert(String query) async {
    final database = await db;
    return await database.rawInsert(query);
  }

  Future<int> update(String query) async {
    final database = await db;
    return await database.rawUpdate(query);
  }

  Future<int> delete(String query) async {
    final database = await db;
    return await database.rawDelete(query);
  }

  Future<List<Map<String, dynamic>>> getAllRows(String query) async {
    final database = await db;
    return await database.rawQuery(query);
  }

  Future<bool> checkIfDatabaseExists() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await File(path).exists();
  }
}
