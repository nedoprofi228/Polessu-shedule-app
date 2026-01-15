import 'package:json_annotation/json_annotation.dart';


class Pair {
  final String subjectName;
  final String subjectType;
  final String teacherName;
  final String pairNum;
  final String roomNum;
  final String time;
  final String subGroup;

  const Pair({
    required this.subjectName,
    required this.subjectType,
    required this.teacherName,
    required this.pairNum,
    required this.roomNum,
    required this.time,
    required this.subGroup,
  });

}
