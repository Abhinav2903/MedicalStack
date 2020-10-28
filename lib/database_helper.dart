import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

final String tableMeds = 'tmeds';
final String columnId = '_id';
final String columnMed = 'med';
final String columnFrequency = 'frequency';

class Word {
  int id;
  String med;
  int frequency;

  Word();

  // convenience constructor to create a Word object
  Word.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    med = map[columnMed];
    frequency = map[columnFrequency];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnMed: med, columnFrequency: frequency};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyMedDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableMeds (
                $columnId INTEGER PRIMARY KEY,
                $columnMed TEXT NOT NULL,
                $columnFrequency INTEGER NOT NULL
              )
              ''');
  }

  Future<int> insert(Word word) async {
    Database db = await database;
    int id = await db.insert(tableMeds, word.toMap());
    return id;
  }

  Future<Word> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableMeds,
        columns: [columnId, columnMed, columnFrequency],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Word.fromMap(maps.first);
    }
    return null;
  }
}
