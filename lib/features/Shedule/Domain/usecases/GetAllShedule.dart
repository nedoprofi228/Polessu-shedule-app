import 'package:application/common/entities/WeekPairs.dart';
import 'package:application/features/Shedule/Domain/repository/SheduleRepository.dart';

class Getallshedule {
  final SheduleRepository repository;

  const Getallshedule({required this.repository});

  Future<List<WeekPairs>> call(String groupName) async {
    return await repository.getAllShedule(groupName);
  }
}
