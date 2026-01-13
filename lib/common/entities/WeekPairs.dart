import 'package:application/common/entities/DayShedule.dart';

class WeekPairs {
  final int weekNum;
  final List<DayShedule> shedule;

  const WeekPairs({required this.shedule, required this.weekNum});
}
