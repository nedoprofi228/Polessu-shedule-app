import 'package:application/common/entities/WeekPairs.dart';

abstract class SheduleRepository {
  Future<List<WeekPairs>> getAllShedule(String groupName);
}
