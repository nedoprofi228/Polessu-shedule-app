import 'package:application/common/entities/Pair.dart';

class DayShedule {
  final int dayId;
  final String dayName;
  final List<Pair> lessons;

  const DayShedule({
    required this.dayId,
    required this.dayName,
    required this.lessons,
  });
}
