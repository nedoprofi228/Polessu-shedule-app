import 'package:application/common/Registerbloc/registrationBloc.dart';
import 'package:application/common/Registerbloc/registrationState.dart';
import 'package:application/features/Shedule/Presentation/Screen/SheduleAppBar.dart';
import 'package:application/features/Shedule/Presentation/Screen/SheduleScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSheduleScreen extends StatelessWidget {
  const UserSheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return SheduleAppBar(groupName: state.user.group, child: SheduleScreen());
      },
    );
  }
}
