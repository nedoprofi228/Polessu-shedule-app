import 'dart:developer';
import 'dart:io';

import 'package:application/common/entities/WeekPairs.dart';
import 'package:application/features/Shedule/Data/SheduleParser.dart';
import 'package:application/features/Shedule/Domain/repository/SheduleRepository.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class Shedulerepositoryimpl implements SheduleRepository {
  static SheduleRepository? instance;

  final Dio dio;
  final Sheduleparser parser;

  Shedulerepositoryimpl({required this.dio, required this.parser}) {
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
  Future<List<WeekPairs>> getAllShedule(String groupName) async {
    Map<String, dynamic> responce = (await dio.get(
      "https://aboba123.pythonanywhere.com/api/v1/schedule/$groupName",
    )).data;

    return parser.parse(responce);
  }
}
