import 'package:application/common/Registerbloc/registrationBloc.dart';
import 'package:application/common/Registerbloc/registrationEvent.dart';
import 'package:application/common/Registerbloc/registrationState.dart';
import 'package:application/common/searchGroupBloc/SearchGroupBloc.dart';
import 'package:application/common/widgets/SheduleTextField.dart';
import 'package:application/common/widgets/SearchGroupPanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class SelectGroupRegisterWidget extends StatelessWidget {
  const SelectGroupRegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, registerState) {
        return BlocProvider<SearchGroupBloc>(
          create: (context) => getIt<SearchGroupBloc>()..add(LoadingGroups()),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: SearchGroupPanel(
              theme: theme,
              onClick: (searchState, groupName) {
                context.read<RegistrationBloc>().add(
                  Register(group: groupName),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
