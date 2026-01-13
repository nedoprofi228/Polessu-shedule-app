import 'package:application/common/RouterPaths.dart';
import 'package:application/features/Main/screen/MainScreen.dart';
import 'package:application/features/Profile/presentation/screen/ProfileSreeen.dart';
import 'package:application/features/SearchShedule/Presentation/Screen/SearchAppBar.dart';
import 'package:application/features/SearchShedule/Presentation/Screen/SearchSheduleScreen.dart';
import 'package:application/features/Shedule/Presentation/Screen/SheduleAppBar.dart';
import 'package:application/features/Shedule/Presentation/Screen/SheduleScreen.dart';
import 'package:application/features/Shedule/Presentation/Screen/UserSheduleScreen.dart';
import 'package:application/features/registration/presentation/screen/LogInScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Myapprouter {
  const Myapprouter();

  GoRouter build(BuildContext context) {
    return GoRouter(
      routes: [
        ShellRoute(
          builder: (context, state, child) => LoginScreen(child: child),
          routes: [
            ShellRoute(
              builder: (context, state, child) => Mainscreen(child: child),
              routes: [
                GoRoute(
                  path: AppRoutes.shedule,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(key: state.pageKey , child: UserSheduleScreen());
                  },
                ),

                GoRoute(
                  path: AppRoutes.searchShedule,
                  pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey ,
                    child: SearchSheduleScreen(
                      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                    ),
                  ),
                ),

                GoRoute(
                  path: AppRoutes.profile,
                  pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey ,
                    child: ProfileSreeen()),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
