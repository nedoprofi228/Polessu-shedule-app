import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseService{
  Future<Database> getConnection() async {
    var databasesPath = await getDatabasesPath();

    String path = join(databasesPath, 'myDb3.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE SearchHistory(id INTEGER PRIMARY KEY AUTOINCREMENT,groupName TEXT)",
        );
      },
    );
  }
}