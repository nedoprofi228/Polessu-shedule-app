import 'package:application/common/services/DataBaseService.dart';
import 'package:path/path.dart';
import 'package:application/features/SearchShedule/Domain/repositories/SearchGroupRepo.dart';
import 'package:sqflite/sqflite.dart';

class SearchGroupRepoImp implements SearchGroupRepo {
  final DataBaseService dataBaseService;

  const SearchGroupRepoImp({required this.dataBaseService});

  @override
  Future<List<Map>> getSearchHistory() async {
    Database db = await dataBaseService.getConnection();

    return await db.rawQuery("SELECT * FROM SearchHistory");
  }

  @override
  Future<int> saveSearchInHistory(String groupName) async {
    Database db = await dataBaseService.getConnection();

    return await db.rawInsert(
      "INSERT INTO SearchHistory(groupName) VALUES ('$groupName')",
    );
  }

  @override
  Future<void> deleteFromHistory(int id) async {
    Database db = await dataBaseService.getConnection();

    db.rawDelete("DELETE FROM SearchHistory WHERE id = $id");
  }

  @override
  Future<void> deleteHistory() async {
    Database db = await dataBaseService.getConnection();

    db.rawDelete("DELETE FROM SearchHistory WHERE id > 0");
  }
}
