import 'package:application/features/registration/presentation/screen/SelectGroupRegisterWidget.dart';
import 'package:flutter/material.dart';

class ProfileSreeen extends StatelessWidget {
  const ProfileSreeen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(top: 200),
      color: theme.primaryColor.withAlpha(200),
      child: Column(
        children: [
          Text("Сменить группу", style: theme.textTheme.titleLarge),
          SizedBox(height: 10),
          SelectGroupRegisterWidget(),
        ],
      ),
    );
  }
}
