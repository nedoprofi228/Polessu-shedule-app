class SheduleEvent {
  const SheduleEvent();
}

class OpenWeeklyShedule extends SheduleEvent {}

class OpenDayShedule extends SheduleEvent {}

class LoadingShedule extends SheduleEvent {
  final String groupName;
  final LoadingType type;

  const LoadingShedule({required this.groupName, required this.type});
}

enum LoadingType { selfShedule, search }
