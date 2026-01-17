import 'package:application/common/entities/WeekPairs.dart';

class AllShedule {
  final List<WeekPairs> weeks;
  final String hash;
  String? groupName;

  AllShedule({required this.hash, required this.weeks, this.groupName});
}
