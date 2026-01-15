class SheduleEvent {
  const SheduleEvent();
}

class OpenWeeklyShedule extends SheduleEvent {}

class OpenDayShedule extends SheduleEvent {}

class LoadingShedule extends SheduleEvent {
  final String groupName;
  final LoadingAction action;

  const LoadingShedule({required this.groupName, required this.action});
}

enum LoadingAction { get, reload }
