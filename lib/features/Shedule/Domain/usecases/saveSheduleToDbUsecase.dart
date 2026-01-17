import 'package:application/common/entities/WeekPairs.dart';
import 'package:application/features/Shedule/Domain/repository/SheduleRepository.dart';

class SaveSheduleToDbUsecase {
  final SheduleRepository repository;

  const SaveSheduleToDbUsecase({required this.repository});

  Future<void> call(List<WeekPairs> weeks) async {
    return await repository.saveToDataBase(weeks);
  }
}
