import 'package:application/features/registration/domain/entities/User.dart';
import 'package:application/features/registration/domain/usecases/getUserData.dart';
import 'package:application/features/registration/domain/usecases/saveUSerData.dart';
import 'package:application/common/Registerbloc/registrationEvent.dart';
import 'package:application/common/Registerbloc/registrationState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final GetUserDataUsecase getUserData;
  final SaveUserDataUsecase saveUserData;

  RegistrationBloc({required this.getUserData, required this.saveUserData})
    : super(RegistrationState()) {
    on<LoadingUser>((event, emit) async {
      try {
        User? user;
        if ((user = await getUserData()) != null) {
          emit(state.copyWith(user: user, status: RegisterStatus.registered));
          return;
        }

        emit(state.copyWith(user: user, status: RegisterStatus.unRegistered));
      } catch (e) {
        emit(
          state.copyWith(status: RegisterStatus.failure, error: e.toString()),
        );
      }
    });

    on<LogOut>((event, emit) {
      emit(state.copyWith(user: null, status: RegisterStatus.unRegistered));
    });

    on<Register>((event, emit) async {
      try {
        User user = User(group: event.group);
        if (await saveUserData(user)) {
          emit(state.copyWith(user: user, status: RegisterStatus.registered));
          return;
        }

        emit(
          state.copyWith(
            error: "ошибка регистрации",
            status: RegisterStatus.unRegistered,
          ),
        );

        return;
      } catch (e) {
        emit(
          state.copyWith(error: e.toString(), status: RegisterStatus.failure),
        );
      }
    });
  }
}
