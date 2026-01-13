import 'package:application/router/MyAppRouter.dart';
import 'package:application/services/Di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

void main() {
  Di di = Di();
  di.Init();
  WidgetsFlutterBinding.ensureInitialized(); // Обязательно перед обращением к SystemChrome
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );
  runApp(const MyBankingApp());
}

class MyBankingApp extends StatelessWidget {
  const MyBankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Polessu App',
      routerConfig: Myapprouter().build(context),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 254, 247, 255),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(164, 32, 129, 84),
        ),
        primaryColor: const Color.fromARGB(255, 254, 247, 255),
        primaryColorLight: Color.fromARGB(255, 243, 237, 247),
        cardColor: Color.fromARGB(255, 0, 92, 49),
        bottomAppBarTheme: BottomAppBarThemeData(
          color: Color.fromARGB(255, 243, 237, 247),
        ),
        dividerTheme: DividerThemeData(
          color: const Color.fromARGB(52, 96, 125, 139),
        ),
        listTileTheme: ListTileThemeData(
          subtitleTextStyle: TextStyle(
            fontSize: 12,
            color: const Color.fromARGB(158, 0, 0, 0),
          ),
          titleTextStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 75, 75, 75),
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontFamily: "montserrat",
            color: const Color.fromARGB(255, 75, 75, 75),
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontFamily: "montserrat",
            color: const Color.fromARGB(255, 75, 75, 75),
          ),
          bodyLarge: TextStyle(
            fontSize: 15,
            fontFamily: "montserrat",
            color: const Color.fromARGB(255, 75, 75, 75),
            letterSpacing: 1.2,
            height: 1.2,
          ),
          bodyMedium: TextStyle(
            fontSize: 13,
            fontFamily: "montserrat",
            color: const Color.fromARGB(255, 75, 75, 75),
            letterSpacing: 1.2,
            height: 1.2,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            fontSize: 13,
            fontFamily: "montserrat",
            color: const Color.fromARGB(255, 75, 75, 75),
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
