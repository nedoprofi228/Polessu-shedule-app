import 'package:application/features/NavigationBar/screen/NavigationBar.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatelessWidget {
  final Widget child;
  const Mainscreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: child,
      bottomNavigationBar: MyNavigationbar(),
    );
  }
}
