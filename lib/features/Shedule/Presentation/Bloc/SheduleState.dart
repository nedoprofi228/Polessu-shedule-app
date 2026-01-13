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

  const SheduleState({
    this.weeks = const [],
    this.visibleMode = SheduleVisibleMode.dayShedule,
    this.status = SheduleStatus.loading,
    this.error = "",
    this.currentPageIndex = 0,
  });

  @override
  List<Object?> get props => [visibleMode, status, error, currentPageIndex];

  SheduleState copyWith({
    List<WeekPairs>? pairs,
    SheduleVisibleMode? visibleStatus,
    SheduleStatus? status,
    String? error,
    int? currentPageIndex,
  }) {
    return SheduleState(
      weeks: pairs ?? this.weeks,
      visibleMode: visibleStatus ?? this.visibleMode,
      status: status ?? this.status,
      error: error ?? this.error,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }
}

class SheduleFailure extends SheduleState {
  final String message;

  const SheduleFailure({required this.message});
}
