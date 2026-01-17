import 'package:application/common/Registerbloc/registrationBloc.dart';
import 'package:application/common/Registerbloc/registrationState.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleState.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleBloc.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleEvent.dart';
import 'package:application/features/Shedule/Presentation/widgets/notifyWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

GetIt getIt = GetIt.instance;

class SheduleAppBar extends StatelessWidget {
  final String groupName;
  final LoadingType type;
  final Widget child;
  const SheduleAppBar({
    super.key,
    required this.child,
    required this.groupName,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, registertState) {
        return BlocProvider(
          create: (context) =>
              getIt<Shedulebloc>()
                ..add(LoadingShedule(groupName: groupName, type: type)),
          child: BlocConsumer<Shedulebloc, SheduleState>(
            listenWhen: (previous, current) {
              return current.notifyMassage.isNotEmpty && 
                     current.notifyMassage != previous.notifyMassage;
            },
            // 2. Действие: что делать?
            listener: (context, state) {
              showTopNotification(context, state.notifyMassage);
            },
            builder: (context, state) {

              return Column(
                children: [
                  Container(
                    height: 90,
                    padding: EdgeInsets.only(top: 35, left: 20, bottom: 5),
                    decoration: BoxDecoration(color: theme.primaryColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              groupName,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${getWeekDayName(DateTime.now().weekday)} ${DateFormat("dd.MM.yy").format(DateTime.now())}",
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        state.visibleMode == SheduleVisibleMode.dayShedule
                            ? ToWeekSheduleBtn()
                            : ToDaySheduleBtn(),
                      ],
                    ),
                  ),
                  Divider(
                    color: const Color.fromARGB(155, 0, 0, 0),
                    thickness: 0.6,
                    height: 0,
                  ),
                  Expanded(child: child),
                ],
              );
            },
          ),
        );
      },
    );
  }

  String getWeekDayName(int dayNum) {
    switch (dayNum) {
      case 1:
        return "Понедельник";
      case 2:
        return "Вторник";
      case 3:
        return "Среда";
      case 4:
        return "Четверг";
      case 5:
        return "Пятница";
      case 6:
        return "Суббота";
      case 7:
        return "Воскресенье";
    }

    return "хз че так";
  }
}

class ToWeekSheduleBtn extends StatelessWidget {
  const ToWeekSheduleBtn({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        onPressed: () {
          print("перейти к недельному расписанию");
          context.read<Shedulebloc>().add(OpenWeeklyShedule());
        },
        icon: Icon(Icons.calendar_month, color: theme.cardColor, size: 28),
      ),
    );
  }
}

class ToDaySheduleBtn extends StatelessWidget {
  const ToDaySheduleBtn({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        onPressed: () {
          print("перейти к дневному расписанию");
          context.read<Shedulebloc>().add(OpenDayShedule());
        },
        icon: Icon(Icons.calendar_today, color: theme.cardColor, size: 28),
      ),
    );
  }
}
