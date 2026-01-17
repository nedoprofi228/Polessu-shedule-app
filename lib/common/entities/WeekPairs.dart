import 'package:application/common/entities/DayShedule.dart';
import 'package:json_annotation/json_annotation.dart';

// part "weekPairs.g.dart";

@JsonSerializable()
class WeekPairs {
  final int weekNum;
  final List<DayShedule> shedule;

  const WeekPairs({required this.shedule, required this.weekNum});
}
