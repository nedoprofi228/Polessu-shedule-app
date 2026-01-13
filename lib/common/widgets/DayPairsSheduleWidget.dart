import 'package:application/common/entities/Pair.dart';
import 'package:application/common/widgets/PairWidget.dart';
import 'package:flutter/material.dart';

class DayPairsSheduleWidget extends StatelessWidget {
  final String dayName;
  final List<Pair> pairs;
  final bool isActive;

  const DayPairsSheduleWidget({
    super.key,
    required this.pairs,
    required this.dayName,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: _createDaySheduleWidget(pairs, context));
  }

  List<Widget> _createDaySheduleWidget(List<Pair> pairs, BuildContext context) {
    List<Widget> dayPairsWidgets = [
      Text(dayName, style: Theme.of(context).textTheme.bodyMedium),
      SizedBox(height: 15),
    ];

    for (var i = 0; i < pairs.length; i++) {
      String pairTimeStr = pairs[i].time;
      TimeOfDay startPair = getTimeFromStr(pairTimeStr.split('-')[0]);
      TimeOfDay endPair = getTimeFromStr(pairTimeStr.split('-')[1]);
      TimeOfDay currentTime = TimeOfDay.now();

      if (currentTime.isAfter(startPair) &&
          currentTime.isBefore(endPair) &&
          isActive) {
        dayPairsWidgets.add(Pairwidget(pair: pairs[i], isActive: true));
      } else {
        dayPairsWidgets.add(Pairwidget(pair: pairs[i], isActive: false));
      }

      if (pairs.length <= 1 || i == pairs.length - 1) {
        continue;
      }
      dayPairsWidgets.add(
        Divider(indent: 20, endIndent: 20, color: Color.fromARGB(50, 0, 0, 0)),
      );
    }

    return dayPairsWidgets;
  }

  TimeOfDay getTimeFromStr(String strTime) {
    String hours = strTime.split(':')[0];
    String minutes = strTime.split(':')[1];

    return TimeOfDay(hour: int.parse(hours), minute: int.parse(minutes));
  }
}
