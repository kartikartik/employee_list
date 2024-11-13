// the code below is used to create a class database for creating the sqlite database
// for our project
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseProvider {
  // the code below is used to create a static final instance of the Database provider class
  static final DatabaseProvider dbProvider = DatabaseProvider();

  // the code below is used to create an instance of the database from our sqflite package
  Database? database;

  // the code below is used to create a getter for checking that if the database
  // is not null then returning the database else creating a new database

  Future<Database> get db async {
    if (database != null) {
      return database!;
    } else {
      // if (kIsWeb) {
      //   // Initialize FFI
      //   sqfliteFfiInit();

      //   databaseFactory = databaseFactoryFfi;

      //   database = await createDatabase();
      // } else {
      //   // Other platforms (store on real file)
      //   //  database = await databaseFactory.openDatabase((await getApplicationDocumentsDirectory()).path + '/app.db');
      //   database = await createDatabase();
      // }
      database = await createDatabase();

      return database!;
    }
  }

  // the code below is used to create a method to create the database
  Future<Database> createDatabase() async {
    // the code below is used to get the location of the application document directory
    Directory docDirectory = await getApplicationDocumentsDirectory();
    // the code below is useed to get the path where our sqlite database will be located
    // by using the join method
    String path;
    var database;

    if (kIsWeb) {
      sqfliteFfiInit();
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;

      database = await openDatabase(
        '/test/test.db', // the path where our database is located
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE empListTable ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "empName TEXT, "
              "empRole TEXT, "
              "empFromDate TEXT, "
              "empToDate TEXT, "
              "is_done INTEGER "
              ")");
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) {
          if (newVersion > oldVersion) {}
        },
      );
    } else {
      path = join(
          docDirectory.path, "empList.db"); // here empList.db is the name of
      // our database

      // in the line of code below we need to use the openDatabase() method to
      // open the database and create the table using raw sql command
      database = await openDatabase(
        path, // the path where our database is located
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE empListTable ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT, "
              "empName TEXT, "
              "empRole TEXT, "
              "empFromDate TEXT, "
              "empToDate TEXT, "
              "is_done INTEGER "
              ")");
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) {
          if (newVersion > oldVersion) {}
        },
      );
    }

    return database;
  }
}
