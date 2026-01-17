import 'dart:developer';
import 'dart:io';

import 'package:application/common/entities/AllShedule.dart';
import 'package:application/common/entities/DayShedule.dart';
import 'package:application/common/entities/Pair.dart';
import 'package:application/common/entities/WeekPairs.dart';
import 'package:application/common/services/DataBaseService.dart';
import 'package:application/features/Shedule/Data/SheduleParser.dart';
import 'package:application/features/Shedule/Domain/repository/SheduleRepository.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  // TODO: сделать чтобы расписание сначала получалось из бд а потом проверялось с инета
  @override
  Future<AllShedule> getAllSheduleFromServer(String groupName) async {
    Map<String, dynamic> responce = (await dio.get(
      "https://aboba123.pythonanywhere.com/api/v1/schedule/$groupName",
    )).data;

    return parser.parseFromJson(responce);
  }

  @override
  Future<List<WeekPairs>> getAllSheduleFromDb() async {
    Database db = await dataBaseService.getConnection();
    List<WeekPairs> weeks = [];
    List<Map<String, dynamic>> weeksdata = await db.rawQuery("""
    SELECT * 
    FROM Weeks
    """);

    for (var weekData in weeksdata) {
      List<DayShedule> daySheduleList = [];
      List<Map<String, dynamic>> daysData = await db.rawQuery("""
        SELECT * 
        FROM Days
        WHERE weekId = ${weekData["id"]}
      """);

      for (var dayData in daysData) {
        List<Pair> pairs = [];
        List<Map<String, dynamic>> PairsData = await db.rawQuery("""
          SELECT * 
          FROM Pairs
          WHERE dayId = ${dayData["id"]}
        """);

        for (var pair in PairsData) {
          pairs.add(
            Pair(
              subjectName: pair["subjectName"],
              subjectType: pair["subjectType"],
              teacherName: pair["teacherName"],
              pairNum: pair["pairNum"],
              roomNum: pair["roomNum"],
              time: pair["time"],
              subGroup: pair["subGroup"],
            ),
          );
        }
        DayShedule dayShedule = DayShedule(
          dayId: dayData["dayNum"],
          dayName: dayData["dayName"],
          lessons: pairs,
        );

        daySheduleList.add(dayShedule);
      }

      weeks.add(
        WeekPairs(shedule: daySheduleList, weekNum: weekData["weekNum"]),
      );
    }

    return weeks;
  }

  @override
  Future<void> saveToDataBase(List<WeekPairs> weeks) async {
    Database db = await dataBaseService.getConnection();

    db.rawDelete("DELETE FROM Weeks WHERE id > 0");

    await db.transaction((txn) async {
      for (var week in weeks) {
        int weekId = await txn.rawInsert(
          'INSERT INTO Weeks(weekNum) VALUES(${week.weekNum})',
        );

        for (var day in week.shedule) {
          int dayId = await txn.rawInsert("""
              INSERT INTO Days(
                dayNum,
                dayName,
                weekId) 
              VALUES(
                '${day.dayId}', 
                '${day.dayName}', 
                $weekId)
            """);

          for (var pair in day.lessons) {
            await txn.rawInsert("""
            INSERT INTO Pairs(
              subjectName,
              subjectType,
              teacherName,
              pairNum,
              roomNum,
              time,
              subGroup,
              dayId) 
            VALUES(
              '${pair.subjectName}',
              '${pair.subjectType}',
              '${pair.teacherName}',
              '${pair.pairNum}',
              '${pair.roomNum}',
              '${pair.time}',
              '${pair.subGroup}',
              $dayId)
            """);
          }
        }
      }
    });
  }
}
