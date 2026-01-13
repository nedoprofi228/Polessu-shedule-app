import 'package:path/path.dart';
import 'package:application/features/SearchShedule/Domain/repositories/SearchGroupRepo.dart';
import 'package:sqflite/sqflite.dart';

class SearchGroupRepoImp implements SearchGroupRepo {
  @override
  Future<List<Map>> getSearchHistory() async {
    Database db = await getConnection();

    return await db.rawQuery("SELECT * FROM SearchHistory");
  }

  @override
  Future<int> saveSearchInHistory(String groupName) async {
    Database db = await getConnection();

    return await db.rawInsert(
      "INSERT INTO SearchHistory(groupName) VALUES ('$groupName')",
    );
  }

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

  @override
  Future<void> deleteFromHistory(int id) async {
    Database db = await getConnection();

    db.rawDelete("DELETE FROM SearchHistory WHERE id = $id");
  }
  
  @override
  Future<void> deleteHistory() async {
     Database db = await getConnection();

    db.rawDelete("DELETE FROM SearchHistory WHERE id > 0");
  }
}
