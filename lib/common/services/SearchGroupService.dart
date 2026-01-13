class SearchGtroupService {
  SearchGtroupService();

  List<String> searchGroups(String searchText, List<String> groups) {
    return groups
        .where((g) => g.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }
}
