import 'dart:math';

import 'package:application/features/Shedule/Presentation/Bloc/SheduleState.dart';
import 'package:application/common/entities/WeekPairs.dart';
import 'package:application/common/widgets/DayPairsSheduleWidget.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleBloc.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleEvent.dart';
import 'package:application/features/Shedule/Presentation/Screen/SheduleAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

GetIt getIt = GetIt.instance;

class SheduleScreen extends StatelessWidget {
  const SheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // TODO: сделать сихронное передвижение дат с расписанием
    // shedulePageController.addListener(() {
    //   var width = MediaQuery.of(context).size.width;
    //   var touchOffset = shedulePageController.page ?? 0;
    //   var offset = width / 2 * touchOffset;
    //  datePageController.jumpTo(offset);
    // });

    return BlocBuilder<Shedulebloc, SheduleState>(
      builder: (context, state) {
        if (state.status == SheduleStatus.failure) {
          return Text(state.error);
        }

        if (state.status != SheduleStatus.loaded) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: theme.cardColor),
              SizedBox(height: 20),
              Text("загрузка пар...", style: theme.textTheme.bodyLarge),
            ],
          );
        }
        var pageIndex = state.visibleMode == SheduleVisibleMode.dayShedule
            ? getCurrentPageOfDays(state.weeks)
            : getCurrentPageOfWeeks(state.weeks);

        PageController datePageController = PageController(
          initialPage: pageIndex,
          viewportFraction: state.visibleMode == SheduleVisibleMode.dayShedule
              ? 0.4
              : 0.5,
        );

        PageController shedulePageController = PageController(
          initialPage: pageIndex,
        );

        final pageViewKey = ValueKey(state.visibleMode);

        return Column(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(color: theme.primaryColor),

              child: PageView(
                key: pageViewKey,
                physics: NeverScrollableScrollPhysics(),
                controller: datePageController,
                children: state.visibleMode == SheduleVisibleMode.dayShedule
                    ? getDayDateList(state.weeks)
                    : getWeekentDateList(state.weeks),
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: PageView(
                key: pageViewKey,
                controller: shedulePageController,
                onPageChanged: (value) => {
                  datePageController.animateToPage(
                    value,
                    duration: Duration(microseconds: 1000),
                    curve: Curves.bounceIn,
                  ),
                },
                children: state.visibleMode == SheduleVisibleMode.dayShedule
                    ? daySheduleList(state.weeks)
                    : weekSheduleList(state.weeks),
              ),
            ),
          ],
        );
      },
    );
  }

  int getCurrentPageOfWeeks(List<WeekPairs> weeks) {
    DateTime currentDate = DateTime.now();

    for (var i = 0; i < weeks.length; i++) {
      DateTime startDate = DateTime(
        2025,
        9,
        0,
      ).add(Duration(days: weeks[i].weekNum * 7 + 1));
      DateTime endDate = DateTime(
        2025,
        9,
        0,
      ).add(Duration(days: weeks[i].weekNum * 7 + 6));

      print(
        "i: $i, start date: $startDate, end date: $endDate, current date: $currentDate",
      );
      print(currentDate.isAfter(startDate) && currentDate.isBefore(endDate));
      if (currentDate.isAfter(startDate) && currentDate.isBefore(endDate)) {
        return i;
      }
    }

    return weeks.length - 1;
  }

  int getCurrentPageOfDays(List<WeekPairs> weeks) {
    int dayCount = 0;

    DateTime currentDate = DateTime.now();

    for (var week in weeks) {
      int curentDayOffset = week.weekNum * 7;

      for (var day in week.shedule) {
        DateTime date = DateTime(
          2025,
          9,
          1,
        ).add(Duration(days: curentDayOffset + day.dayId));

        if (currentDate.day <= date.day &&
            currentDate.month <= date.month &&
            currentDate.year <= date.year) {
          return dayCount;
        }

        dayCount++;
      }
    }

    return dayCount;
  }

  List<Widget> getWeekentDateList(List<WeekPairs> weeks) {

    DateTime startTime;
    DateTime currentDate = DateTime.now();
    if (currentDate.month <= 12 &&
        currentDate.month >= 9 &&
        currentDate.day < 19) {
      startTime = DateTime(currentDate.year, 9, 1);
    }else{
      startTime = DateTime(currentDate.year, 1, 19);
    }

    var dateList = List.generate(weeks.length, (i) {
      DateTime startDate = startTime.add(Duration(days: weeks[i].weekNum * 7 + 1));
      DateTime endDate = startTime.add(Duration(days: weeks[i].weekNum * 7 + 6));

      return Center(
        child: Text(
          "${DateFormat("dd.MM.yy").format(startDate)} - ${DateFormat("dd.MM.yy").format(endDate)}",
        ),
      );
    });

    return dateList;
  }

  List<Widget> getDayDateList(List<WeekPairs> weeks) {
    List<Widget> pairDateList = [];

    DateTime startTime;
    DateTime currentDate = DateTime.now();
    if (currentDate.month <= 12 &&
        currentDate.month >= 9 &&
        currentDate.day < 19) {
      startTime = DateTime(currentDate.year, 9, 1);
    }else{
      startTime = DateTime(currentDate.year, 1, 19);
    }

    for (var week in weeks) {
      int curentDayOffset = week.weekNum * 7;

      for (var day in week.shedule) {
        DateTime date = startTime.add(Duration(days: curentDayOffset + day.dayId));

        pairDateList.add(
          Center(
            child: Text(
              "${getDayNameByNum(day.dayId)} ${DateFormat("dd.MM.yy").format(date)}",
            ),
          ),
        );
      }
    }

    return pairDateList;
  }

  String getDayNameByNum(int num) {
    switch (num) {
      case 0:
        return "пн";
      case 1:
        return "вт";
      case 2:
        return "ср";
      case 3:
        return "чт";
      case 4:
        return "пт";
      case 5:
        return "сб";
      default:
        return "-";
    }
  }

  List<Widget> daySheduleList(List<WeekPairs> weeks) {
    List<Widget> daySheduleList = [];
    DateTime startTime;
    DateTime currentDate = DateTime.now();
    if (currentDate.month <= 12 &&
        currentDate.month >= 9 &&
        currentDate.day < 19) {
      startTime = DateTime(currentDate.year, 9, 1);
    }else{
      startTime = DateTime(currentDate.year, 1, 19);
    }
    for (var week in weeks) {
      daySheduleList.addAll(
        week.shedule.map((day) {
          startTime.add(Duration(days: week.weekNum * 7 + day.dayId));
          return DayPairsSheduleWidget(
            pairs: day.lessons,
            dayName: day.dayName,
            isActive: startTime.isAtSameMomentAs(currentDate),
          );
        }),
      );
    }

    return daySheduleList;
  }

  List<Widget> weekSheduleList(List<WeekPairs> weekPairsList) {
    return weekPairsList
        .map(
          (week) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: week.shedule
                  .map(
                    (dayShedule) => Column(
                      children: [
                        DayPairsSheduleWidget(
                          pairs: dayShedule.lessons,
                          dayName: dayShedule.dayName,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        )
        .toList();
  }
}
