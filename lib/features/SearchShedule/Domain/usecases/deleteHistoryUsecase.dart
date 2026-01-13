import 'package:application/features/SearchShedule/Domain/repositories/SearchGroupRepo.dart';

class Deletehistoryusecase {
  final SearchGroupRepo repository;

  const Deletehistoryusecase({required this.repository});

  Future<void> call() async {
    await repository.deleteHistory();
  }
}
