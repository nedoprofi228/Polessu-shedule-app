import 'package:application/common/Registerbloc/registrationBloc.dart';
import 'package:application/common/Registerbloc/registrationState.dart';
import 'package:application/features/Shedule/Presentation/widgets/notifyWidget.dart';
import 'package:application/features/registration/presentation/screen/SelectGroupRegisterWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileSreeen extends StatelessWidget {
  const ProfileSreeen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listenWhen: (previous, current) => previous.user.group != current.user.group,
      listener: (context, state) => showTopNotification(context, "Группа успешно изменена"),
      builder: (context, state) =>  Container(
        padding: EdgeInsets.only(top: 200),
        color: theme.primaryColor.withAlpha(200),
        child: Column(
          children: [
            Text("Сменить группу", style: theme.textTheme.titleLarge),
            Text(state.user.group, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            SelectGroupRegisterWidget(),
          ],
        ),
      ),
    );
  }
}
