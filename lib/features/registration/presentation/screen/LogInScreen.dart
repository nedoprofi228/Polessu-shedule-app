import 'package:application/common/Registerbloc/registrationBloc.dart';
import 'package:application/common/Registerbloc/registrationEvent.dart';
import 'package:application/common/Registerbloc/registrationState.dart';
import 'package:application/features/registration/presentation/screen/SelectGroupRegisterWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class LoginScreen extends StatelessWidget {
  final Widget child;
  const LoginScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocProvider<RegistrationBloc>(
      create: (context) => getIt<RegistrationBloc>()..add(LoadingUser()),
      child: Container(
        color: theme.primaryColor,
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          builder: (context, state) {
            // if (state.status == RegisterStatus.failure) {
            //   return Center(
            //     child: Row(
            //       children: [
            //         Text(
            //           state.error == "" ? "ошибка регистрации" : state.error,
            //           style: theme.textTheme.titleMedium,
            //         ),
            //       ],
            //     ),
            //   );
            // }

            if (state.status == RegisterStatus.loading) {
              return Container(
                color: theme.primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(
                      "загрузка пользователя",
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }

            if (state.status == RegisterStatus.unRegistered ||
                state.status == RegisterStatus.failure) {
              return Container(
                color: theme.primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 100),
                    Text("Регистрация", style: theme.textTheme.titleLarge),
                    SizedBox(height: 100),
                    Expanded(child: SelectGroupRegisterWidget()),
                  ],
                ),
              );
            }

            return child;
          },
        ),
      ),
    );
  }
}
