import 'package:application/features/SearchShedule/Domain/repositories/SearchGroupRepo.dart';

class SaveSearchInHistoryUsecase {
  final SearchGroupRepo repository;

  const SaveSearchInHistoryUsecase({required this.repository});

  Future<int> call(String groupName) {
    return repository.saveSearchInHistory(groupName);
  }
}
