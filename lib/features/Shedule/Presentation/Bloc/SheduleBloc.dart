import 'package:application/common/entities/AllShedule.dart';
import 'package:application/common/entities/WeekPairs.dart';
import 'package:application/features/Shedule/Data/SheduleRepositoryImpl.dart';
import 'package:application/features/Shedule/Domain/usecases/getAllSheduleFromDbUsecase.dart';
import 'package:application/features/Shedule/Domain/usecases/getAllSheduleFromServer.dart';
import 'package:application/features/Shedule/Domain/usecases/saveSheduleToDbUsecase.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleEvent.dart';
import 'package:application/features/Shedule/Presentation/Bloc/SheduleState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shedulebloc extends Bloc<SheduleEvent, SheduleState> {
  static AllShedule? currentShedule;

  final GetAllSheduleFromServer getAllSheduleFromServerUsecase;
  final GetAllSheduleFromDbUsecase getAllSheduleFromDbUsecase;
  final SaveSheduleToDbUsecase saveSheduleToDbUsecase;

  Shedulebloc({
    required this.getAllSheduleFromServerUsecase,
    required this.getAllSheduleFromDbUsecase,
    required this.saveSheduleToDbUsecase,
  }) : super(const SheduleState()) {
    on<OpenDayShedule>(
      (event, emit) =>
          emit(state.copyWith(visibleMode: SheduleVisibleMode.dayShedule)),
    );

    on<OpenWeeklyShedule>(
      (event, emit) =>
          emit(state.copyWith(visibleMode: SheduleVisibleMode.weekShedule)),
    );

    on<LoadingShedule>((event, emit) async {
      try {
        if (event.type == LoadingType.search) {
          AllShedule searchShedule = await getAllSheduleFromServerUsecase(
            event.groupName,
          );
          emit(
            state.copyWith(
              weeks: searchShedule.weeks,
              status: SheduleStatus.loaded,
            ),
          );
          return;
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (currentShedule == null) {
          List<WeekPairs> pairs = await getAllSheduleFromDbUsecase();
          currentShedule = AllShedule(
            hash: prefs.getString("hash") ?? "",
            weeks: pairs,
            groupName: event.groupName
          );
        }

        if (currentShedule!.weeks.isNotEmpty &&
            currentShedule!.groupName == event.groupName) {
          emit(
            state.copyWith(
              weeks: currentShedule!.weeks,
              status: SheduleStatus.loaded,
            ),
          );
        }

        AllShedule sheduleFromServer = await getAllSheduleFromServerUsecase(
          event.groupName,
        );
        if (sheduleFromServer.hash != currentShedule!.hash) {
          currentShedule = AllShedule(
            groupName: event.groupName,
            hash: sheduleFromServer.hash,
            weeks: sheduleFromServer.weeks,
          );

          emit(
            state.copyWith(
              weeks: sheduleFromServer.weeks,
              status: SheduleStatus.loaded,
              notifyMassage: "Расписание обновлено",
            ),
          );

          await saveSheduleToDbUsecase(sheduleFromServer.weeks);
          prefs.setString("hash", sheduleFromServer.hash);
          return;
        }
      } catch (e) {
        emit( 
          state.copyWith(status: SheduleStatus.loaded, error: e.toString()),
        );
      }
    });
  }
}
