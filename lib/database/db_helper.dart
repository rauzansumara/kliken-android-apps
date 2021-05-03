import 'package:kliken/model/library.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();

  DBHelper.internal();

  factory DBHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDb();
    return _db;
  }

  setDb() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'db');
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("""CREATE TABLE news(
      id INTEGER PRIMARY KEY,
      title TEXT,
      link TEXT,
      date TEXT, 
      img TEXT, 
      media TEXT,
      type TEXT
    )""");
    print("DB Created");
  }

  // TODO: jika sudah terdapat record yang sama, maka jangan tambahkan record tersebut
  Future<int> saveNews(News news) async {
    var dbClient = await db;
    int res = await dbClient.insert("news", news.toMap());
    print("Data inserted");
    return res;
  }

  Future<List<News>> getNewsFromDB() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM news");
    List<News> newsData = List();
    for (int i = 0; i < list.length; i++) {
      var news = News(
          title: list[i]['title'],
          link: list[i]['link'],
          media: list[i]['media'],
          img: list[i]['img'],
          date: list[i]['date']);
      newsData.add(news);
    }
    print("Get Data");
    return newsData;
  }

  Future<int> deleteNews(News news) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete("DELETE FROM news WHERE title= ?", [news.title]);
    print("Delete Data");
    return res;
  }
}
