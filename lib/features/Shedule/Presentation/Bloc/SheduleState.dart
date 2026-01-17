import 'package:application/common/entities/Pair.dart';
import 'package:application/common/entities/WeekPairs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum SheduleVisibleMode { dayShedule, weekShedule }

enum SheduleStatus { loading, loaded, failure }

class SheduleState extends Equatable {
  final List<WeekPairs> weeks;
  final SheduleVisibleMode visibleMode;
  final SheduleStatus status;
  final String error;
  final int currentPageIndex;
  final String notifyMassage;

  const SheduleState({
    this.weeks = const [],
    this.visibleMode = SheduleVisibleMode.dayShedule,
    this.status = SheduleStatus.loading,
    this.error = "",
    this.currentPageIndex = 0,
    this.notifyMassage = ""
  });

  @override
  List<Object?> get props => [visibleMode, status, error, currentPageIndex, notifyMassage];

  SheduleState copyWith({
    List<WeekPairs>? weeks,
    SheduleVisibleMode? visibleMode,
    SheduleStatus? status,
    String? error,
    int? currentPageIndex,
    String? notifyMassage
  }) {
    return SheduleState(
      weeks: weeks ?? this.weeks,
      visibleMode: visibleMode ?? this.visibleMode,
      status: status ?? this.status,
      error: error ?? this.error,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      notifyMassage: notifyMassage ?? this.notifyMassage
    );
  }
}

class SheduleFailure extends SheduleState {
  final String message;

  const SheduleFailure({required this.message});
}
