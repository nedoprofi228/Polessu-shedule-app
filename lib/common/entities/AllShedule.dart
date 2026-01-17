import 'package:application/common/entities/WeekPairs.dart';

class AllShedule {
  final List<WeekPairs> weeks;
  final String hash;

  const AllShedule({required this.hash, required this.weeks});
}
