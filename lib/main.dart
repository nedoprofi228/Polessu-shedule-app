import 'package:application/router/MyAppRouter.dart';
import 'package:application/services/Di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  Di di = Di();
  di.Init();
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
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 0, 92, 49),
        ),
        primaryColor: const Color.fromARGB(255, 0, 92, 49),
        primaryColorLight: Colors.white,
        cardColor: Color.fromARGB(255, 0, 92, 49),
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
            color: Colors.black,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 18,
            fontFamily: "montserrat",
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            fontFamily: "montserrat",
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 15,
            fontFamily: "montserrat",
            color: Colors.black,
            letterSpacing: 1.2,
            height: 1.2,
          ),
          bodyMedium: TextStyle(
            fontSize: 13,
            fontFamily: "montserrat",
            color: Colors.black,
            letterSpacing: 1.2,
            height: 1.2,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: TextStyle(
            fontSize: 13,
            fontFamily: "montserrat",
            color: Colors.black,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
