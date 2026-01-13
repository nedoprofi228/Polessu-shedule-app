import 'package:application/features/SearchShedule/Data/SearchGroupRepoImp.dart';
import 'package:application/features/SearchShedule/Domain/repositories/SearchGroupRepo.dart';

class DeleteSearchHistoryUsecase {
  final SearchGroupRepo repository;

  const DeleteSearchHistoryUsecase({required this.repository});

  Future<void> call(int id) async {
    await repository.deleteFromHistory(id);
  }
}
