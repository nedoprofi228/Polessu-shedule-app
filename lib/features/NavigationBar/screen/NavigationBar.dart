import 'package:application/common/RouterPaths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyNavigationbar extends StatelessWidget {
  const MyNavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    int selectedIndex = _SelectedIndex(context);

    return NavigationBar(
      selectedIndex: selectedIndex,
      backgroundColor: theme.bottomAppBarTheme.color,
      height: 70,
      destinations: [
        Column(
          children: [
            IconButton(
              highlightColor: const Color.fromARGB(74, 175, 175, 175),
              icon: selectedIndex == 0
                  ? Icon(Icons.refresh, color: theme.cardColor)
                  : Icon(Icons.home, color: Colors.black),
              onPressed: () => selectedIndex == 0
                  ? context.go("${AppRoutes.shedule}?action=update")
                  : context.go("${AppRoutes.shedule}?action=get"),
            ),
            selectedIndex == 0
                ? Text("обновить", style: TextStyle(color: theme.cardColor))
                : Text("расписание", style: TextStyle(color: Colors.black)),
          ],
        ),
        Column(
          children: [
            IconButton(
              highlightColor: const Color.fromARGB(74, 175, 175, 175),
              icon: Icon(
                Icons.search,
                color: selectedIndex == 1 ? theme.cardColor : Colors.black,
              ),
              onPressed: () {
                String path =
                    "${AppRoutes.searchShedule}?t=${DateTime.now().millisecondsSinceEpoch}";

                context.go(path);
              },
            ),
            Text(
              "поиск",
              style: TextStyle(
                color: selectedIndex == 1 ? theme.cardColor : Colors.black,
              ),
            ),
          ],
        ),
        Column(
          children: [
            IconButton(
              highlightColor: const Color.fromARGB(74, 175, 175, 175),
              icon: Icon(
                Icons.person,
                color: selectedIndex == 2 ? theme.cardColor : Colors.black,
              ),
              onPressed: () => context.go(AppRoutes.profile),
            ),
            Text(
              "профиль",
              style: TextStyle(
                color: selectedIndex == 2 ? theme.cardColor : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  int _SelectedIndex(BuildContext context) {
    var path = GoRouter.of(context).state.path;
    switch (path) {
      case AppRoutes.shedule:
        return 0;
      case AppRoutes.searchShedule:
        return 1;
      case AppRoutes.profile:
        return 2;
      default:
        return 0;
    }
  }
}
