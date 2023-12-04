import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'hegazy.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    //الباتش ديما بتستخدم لما اعوز اعمل كذاامر مع بعض ومش شرط مع sqlflite بس
    Batch batch = db.batch();
    batch.execute('''
    CREATE TABLE "notes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
  )
  ''');
    batch.execute('''
    CREATE TABLE "quotes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "quote" TEXT NOT NULL
  )
  ''');
    await batch.commit();
    print("Create Database and Table ===================");
  }

  FutureOr<void> _onUpgrade(
      Database database, int oldVersion, int newVersion) async {
    //بيتم استدعائها لما نغير رقم الفيرجن

    database.execute("ALTER TABLE notes ADD COLUMN color Text");
    print("onUpgrade ==========");
  }

  getData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
    //لو رجع صفر يبقا حصل العملية فشلت
    //لو رجع اي رقم تاني يبقا نجحت
  }

  updatetData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  deleteMyDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'hegazy.db');
    deleteDatabase(path);
  }
}
