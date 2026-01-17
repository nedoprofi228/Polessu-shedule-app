import 'package:application/common/entities/AllShedule.dart';
import 'package:application/common/entities/DayShedule.dart';
import 'package:application/common/entities/Pair.dart';
import 'package:application/common/entities/WeekPairs.dart';

class Sheduleparser {
  AllShedule parseFromJson(Map<String, dynamic> data) {
    List<WeekPairs> weekSheduleList = [];

    for (var weekData in data["schedule"] as List<dynamic>) {
      List<DayShedule> weekShedule = [];

      for (var dayData in weekData["days"] as List<dynamic>) {
        List<Pair> dayPairs = [];

        for (var pairData in dayData["lessons"] as List<dynamic>) {
          Pair pair = Pair(
            subjectName: pairData["subject"],
            subjectType: pairData["sub-type"],
            teacherName: pairData["details"],
            pairNum: pairData["pair_num"].toString(),
            roomNum: pairData["room"],
            time: pairData["time"],
            subGroup: pairData["subgroup"],
          );

          dayPairs.add(pair);
        }

        DayShedule dayShedule = DayShedule(
          dayId: dayData["day_id"],
          dayName: dayData["day_name"],
          lessons: dayPairs,
        );

        weekShedule.add(dayShedule);
      }

      WeekPairs weekPairs = WeekPairs(
        weekNum: weekData["week_number"],
        shedule: weekShedule,
      );
      weekSheduleList.add(weekPairs);
    }

    AllShedule allShedule = AllShedule(hash: data["hash"], weeks: weekSheduleList);
    return allShedule;
  }
}
