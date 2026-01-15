import 'package:application/common/entities/WeekPairs.dart';
import 'package:application/features/Shedule/Domain/repository/SheduleRepository.dart';

class GetAllSheduleFromServer {
  final SheduleRepository repository;

  const GetAllSheduleFromServer({required this.repository});

  Future<List<WeekPairs>> call(String groupName) async {
    return await repository.getAllSheduleFromServer(groupName);
  }
}
