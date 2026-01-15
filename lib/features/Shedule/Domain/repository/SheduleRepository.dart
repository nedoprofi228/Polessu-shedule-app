import 'package:application/common/entities/WeekPairs.dart';

abstract class SheduleRepository {
  Future<List<WeekPairs>> getAllSheduleFromServer(String groupName);

  Future<List<WeekPairs>> getAllSheduleFromDb();
  
}
