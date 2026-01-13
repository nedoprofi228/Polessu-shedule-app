class SheduleEvent {
  const SheduleEvent();
}

class OpenWeeklyShedule extends SheduleEvent {}

class OpenDayShedule extends SheduleEvent {}

class LoadingShedule extends SheduleEvent {
  final String groupName;

  const LoadingShedule({required this.groupName});
}
