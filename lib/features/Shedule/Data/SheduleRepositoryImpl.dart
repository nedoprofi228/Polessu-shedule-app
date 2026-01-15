import 'dart:developer';
import 'dart:io';

import 'package:application/common/entities/WeekPairs.dart';
import 'package:application/common/services/DataBaseService.dart';
import 'package:application/features/Shedule/Data/SheduleParser.dart';
import 'package:application/features/Shedule/Domain/repository/SheduleRepository.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Shedulerepositoryimpl implements SheduleRepository {
  static SheduleRepository? instance;

  final Dio dio;
  final Sheduleparser parser;
  final DataBaseService dataBaseService;

  Shedulerepositoryimpl({
    required this.dio,
    required this.parser,
    required this.dataBaseService,
  }) {
    // {
    //   (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    //     final client = HttpClient();

    //     // Разрешаем ВСЕ сертификаты (опасно для продакшена, ок для тестов)
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;

    //     return client;
    //   };
    // }
  }

  // для
  //

  @override
  Future<List<WeekPairs>> getAllSheduleFromServer(String groupName) async {
    Map<String, dynamic> responce = (await dio.get(
      "https://aboba123.pythonanywhere.com/api/v1/schedule/$groupName",
    )).data;

    return parser.parseFromJson(responce);
  }

  @override
  Future<List<WeekPairs>> getAllSheduleFromDb() async {
    Database db = await dataBaseService.getConnection();

    List<Map<String, dynamic>> data = await db.rawQuery("""
    SELECT * 
    FROM Weeks AS w
    LEFT JOIN Days as d ON d.weekId = w.id
    LEFT JOIN Pair as p ON p.dayId = d.id
    """);

    return parser.parseFromDb(data);
  }
}
