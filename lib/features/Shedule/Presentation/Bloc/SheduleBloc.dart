import 'package:application/features/Shedule/Data/SheduleRepositoryImpl.dart';
import 'package:application/features/Shedule/Domain/usecases/GetAllShedule.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleEvent.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Shedulebloc extends Bloc<SheduleEvent, SheduleState> {
  final Getallshedule getAllSheduleUsecase;

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
        emit(
          state.copyWith(
            pairs: await getAllSheduleUsecase(event.groupName),
            status: SheduleStatus.loaded,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(status: SheduleStatus.failure, error: e.toString()),
        );
      }
    });
  }
}
