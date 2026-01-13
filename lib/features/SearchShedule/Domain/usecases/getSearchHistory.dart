import 'package:application/features/SearchShedule/Domain/entities/searchHistoryEntity.dart';
import 'package:application/features/SearchShedule/Domain/repositories/SearchGroupRepo.dart';

class GetSearchHistory {
  final SearchGroupRepo repository;

  const GetSearchHistory({required this.repository});

  Future<List<SearchHistoryEntity>> call() async {
    return (await repository.getSearchHistory())
        .map((e) => SearchHistoryEntity(groupName:  e["groupName"], id: e["id"]))
        .toList();
  }
}
