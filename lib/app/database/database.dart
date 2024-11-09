import 'package:faker/faker.dart';
import 'package:tea_tasting/app/data/homedata.dart';
import 'package:tea_tasting/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:tea_tasting/common/assets/assets.dart';
import 'package:sqflite/sqflite.dart';

class FFFFFFDatabase extends GetxService {
  late Database db;
  String lastTime = "";
  Future<FFFFFFDatabase> init() async {
    await initDB();
    return this;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'record_db.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await createTable(db);
      await createDefaultData(db);
    });
    reloadhomeData();
  }

  void reloadhomeData() async {
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().getAllRecords();
    }
  }

  createTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS recordItem (id INT AUTO_INCREMENT PRIMARY KEY, title TEXT,comment TEXT, image TEXT,record INT,time TEXT)');
  }

  createDefaultData(Database db) async {
    final teas = ["Longjing", "Tieguanyin", "Pu'er tea", "Rock tea"];
    final teaspngs = [Assets.long, Assets.long2, Assets.long3, Assets.long4];
    final cs = [
      "The taste of Longjing tea is mellow and long, and each bite has a unique charm of Jiangnan…",
      "The aroma is high and quiet, the taste is mellow and sweet, and the aftertaste is endless",
      "The taste of Pu 'er tea is rich and varied, among which the unique Pu 'er tea soup tastes fresh and sweet",
      "The taste of rock tea is as smooth as velvet, warm and delicate, and each bite can feel its depth"
    ];

    final time = DateTime.now();
    //time.year
    final timeStr = "${1970}/${time.month}/${time.day}";
    lastTime = timeStr;
    for (var i = 0; i < teas.length; i++) {
      final str = cs[i];
      db.insert(
        'recordItem',
        {
          'title': teas[i],
          'comment': str,
          'image': teaspngs[i],
          'record': random.integer(5),
          "time": i == 0 ? timeStr : ""
        },
      );
    }
  }

  insert(RecordModel recordItem) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'record_db.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});

    final timeStr = lastTime == recordItem.time ? "" : recordItem.time!;

    await db.insert('recordItem', {
      'title': recordItem.title,
      'comment': recordItem.comment,
      'image': recordItem.image,
      'time': timeStr,
      'record': recordItem.record,
    });

    lastTime = recordItem.time!;
  }

  update(RecordModel recordItem) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'record_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.update(
        'recordItem',
        {
          'title': recordItem.title,
          'comment': recordItem.comment,
          'image': recordItem.image,
          'time': recordItem.time,
          'record': recordItem.record,
        },
        where: 'id = ?',
        whereArgs: [
          recordItem.id,
        ]);
  }

  delete(int id) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'record_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});

    db.delete('recordItem', where: 'id = ?', whereArgs: [id]);
  }

  clean() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'record_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.delete('recordItem');
  }

  Future<List<RecordModel>> getAll() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'record_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    var result = await db.query('recordItem',orderBy:'id ASC');
    return result.map((e) => RecordModel.fromJson(e)).toList();
  }
}
