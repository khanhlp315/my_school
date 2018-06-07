import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataAccessHelper
{
  static Database database;

  static Future<Database> connectDatabase()
  async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "qlhs.db");
    database = await openDatabase(path);
    return database;
  }

  static Future closeDatabase()
  async {
    await database.close();
  }
}