import 'package:application/common/entities/WeekPairs.dart';
import 'package:application/features/Shedule/Domain/repository/SheduleRepository.dart';

class GetAllSheduleFromDbUsecase {
  final SheduleRepository repository;

  const GetAllSheduleFromDbUsecase({required this.repository});

  Future<List<WeekPairs>> call() async {
    return await repository.getAllSheduleFromDb();
  }
}
