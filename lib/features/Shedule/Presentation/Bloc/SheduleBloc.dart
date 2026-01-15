import 'package:application/common/entities/WeekPairs.dart';
import 'package:application/features/Shedule/Data/SheduleRepositoryImpl.dart';
import 'package:application/features/Shedule/Domain/usecases/getAllSheduleFromServer.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleEvent.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Shedulebloc extends Bloc<SheduleEvent, SheduleState> {
  final GetAllSheduleFromServer getAllSheduleUsecase;

  Shedulebloc({required this.getAllSheduleUsecase})
    : super(const SheduleState()) {
    on<OpenDayShedule>(
      (event, emit) =>
          emit(state.copyWith(visibleStatus: SheduleVisibleMode.dayShedule)),
    );

    on<OpenWeeklyShedule>(
      (event, emit) =>
          emit(state.copyWith(visibleStatus: SheduleVisibleMode.weekShedule)),
    );

    on<LoadingShedule>((event, emit) async {
      try {
        List<WeekPairs> pairs = await getAllSheduleUsecase(event.groupName);

        emit(state.copyWith(pairs: pairs, status: SheduleStatus.loaded));
      } catch (e) {
        emit(
          state.copyWith(status: SheduleStatus.failure, error: e.toString()),
        );
      }
    });
  }
}
