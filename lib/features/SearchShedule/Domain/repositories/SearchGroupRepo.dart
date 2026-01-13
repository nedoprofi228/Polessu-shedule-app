abstract class SearchGroupRepo {
  Future<int> saveSearchInHistory(String groupName);
  Future<List<Map>> getSearchHistory();
  Future<void> deleteFromHistory(int id);
  Future<void> deleteHistory();
}
