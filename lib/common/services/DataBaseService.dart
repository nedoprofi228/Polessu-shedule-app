import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseService {
  // 1. Singleton паттерн: храним единственное соединение
  static Database? _database;

  Future<Database> getConnection() async {
    // Если соединение уже есть - возвращаем его
    if (_database != null) return _database!;

    // Если нет - инициализируем
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'myDbFinal2.db'); // Лучше сменить имя файла для чистого старта

    return await openDatabase(
      path,
      version: 1,
      // 2. ВАЖНО: Включаем поддержку внешних ключей (ON DELETE CASCADE)
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      // 3. Создаем таблицы по одной
      onCreate: (db, version) async {
        // Таблица истории
        await db.execute("""
          CREATE TABLE SearchHistory(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            groupName TEXT
          )
        """);

        // Таблица недель
        await db.execute("""
          CREATE TABLE Weeks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            weekNum INTEGER
          )
        """);

        // Таблица дней
        await db.execute("""
          CREATE TABLE Days(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            dayNum INTEGER,
            dayName TEXT,
            weekId INTEGER,
            FOREIGN KEY(weekId) REFERENCES Weeks(id) ON DELETE CASCADE
          )
        """);

        // Таблица пар
        await db.execute("""
          CREATE TABLE Pairs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            subjectName TEXT,
            subjectType TEXT,
            teacherName TEXT,
            pairNum TEXT,
            roomNum TEXT,
            time TEXT,
            subGroup TEXT,
            dayId INTEGER,
            FOREIGN KEY(dayId) REFERENCES Days(id) ON DELETE CASCADE
          )
        """);
      },
    );
  }
}