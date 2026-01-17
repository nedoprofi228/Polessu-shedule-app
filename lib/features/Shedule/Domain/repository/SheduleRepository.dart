import 'package:application/common/entities/AllShedule.dart';
import 'package:application/common/entities/WeekPairs.dart';

abstract class SheduleRepository {
  Future<AllShedule> getAllSheduleFromServer(String groupName);

  Future<List<WeekPairs>> getAllSheduleFromDb();

  Future<void> saveToDataBase(List<WeekPairs> weeks);
}
