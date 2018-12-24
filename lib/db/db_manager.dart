import 'package:flutter_48_xhdq/bean/shouye_data.dart';
import 'package:flutter_48_xhdq/db/user.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

class DemoSqlManager {
  static final _VERSION = 1;
  static final _NAME = 'xhdq_data.db';
  static Database _database;

  static init() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + _NAME;
    _database = await openDatabase(path,
        version: _VERSION, onCreate: (Database db, int version) async {});
  }

  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database.rawQuery(
        "select * from Sqlite_master where type='table' and name='$tableName'");
    return res != null && res.length > 0;
  }

  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  static close() {
    if (_database != null) {
      _database.close();
      _database = null;
    }
  }
}

abstract class DemoBaseDbProvider {
  bool isTableExits = false;

  tableSqlString();

  tableName();

  tableBaseString(String name, String columnId) {
    return '''create table $name ($columnId integer primary key autoincrement,''';
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await DemoSqlManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await DemoSqlManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), tableSqlString());
    }
    return await DemoSqlManager.getCurrentDatabase();
  }
}

///
/// 用户表
///
class DemoUserInfoDbProvider extends DemoBaseDbProvider {
  final String name = 'UserInfo';
  final String columnId = '_id';
  final String columnUserName = 'userName';
  final String columnPwd = 'pwd';
  final String columnNickNmae = 'nickName';
  int id;
  String userName;
  String pwd;
  String nickName;

  DemoUserInfoDbProvider();

  Map<String, dynamic> toMap(String userName, String pwd, String nickName) {
    Map<String, dynamic> map = {
      columnUserName: userName,
      columnPwd: pwd,
      columnNickNmae: nickName
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  DemoUserInfoDbProvider.fromMap(Map map) {
    id = map[columnId];
    userName = map[columnUserName];
    pwd = map[columnPwd];
    nickName = map[columnNickNmae];
  }

  @override
  tableName() {
    return name;
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
        $columnUserName text not null,
        $columnPwd text not null,
        $columnNickNmae text not null)
      ''';
  }

  ///根据用户名获取用户
  Future getUserProvider(Database db, String userName) async {
    List<Map<String, dynamic>> maps = await db.query(name,
        columns: [columnId, columnUserName, columnPwd, columnNickNmae],
        where: "$columnUserName = ?",
        whereArgs: [userName]);
    if (maps.length > 0) {
      DemoUserInfoDbProvider provider =
          DemoUserInfoDbProvider.fromMap(maps.first);
      return provider;
    }
    return null;
  }

  ///插入
  Future insert(String userName, String pwd, String nickName) async {
    Database db = await getDataBase();
    var userProvider = await getUserProvider(db, userName);
    if (userProvider != null) {
      await db
          .delete(name, where: "$columnUserName = ?", whereArgs: [userName]);
    }
    return await db.insert(name, toMap(userName, pwd, nickName));
  }

  Future<User> getUserInfo(String userName) async {
    Database db = await getDataBase();
    DemoUserInfoDbProvider userProVider = await getUserProvider(db, userName);
    if (userProVider != null) {
      return User(
          id: userProVider.id,
          userName: userProVider.userName,
          pwd: userProVider.pwd,
          nickName: userProVider.nickName);
    }
    return null;
  }
}

///收藏
///int id;
//  String title;
//  int classId;
//  String author;
//  String time;
//  String thumb;
class DatumDbProvider extends DemoBaseDbProvider {
  final String name = 'DatumInfo'; //表名
  final String columnId = '_id';
  final String columnTitle = 'title';
  final String columnClassId = 'classId';
  final String columnAuthor = 'author';
  final String columnTime = 'time';
  final String columnThumb = 'thumb';
  int id;
  String title;
  int classId;
  String author;
  String time;
  String thumb;

  DatumDbProvider();

  Map<String, dynamic> toMap(Datum datum) {
    Map<String, dynamic> map = {
      columnId: datum.id,
      columnTitle: datum.title,
      columnClassId: datum.classId,
      columnAuthor: datum.author,
      columnTime: datum.time,
      columnThumb: datum.thumb
    };
    return map;
  }

  DatumDbProvider.fromMap(Map map) {
    id = map[columnId];
    title = map[columnTitle];
    thumb = map[columnThumb];
    time = map[columnTime];
    author = map[columnAuthor];
    classId = map[columnClassId];
  }

  @override
  tableName() {
    return name;
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
        $columnClassId integer,
        $columnAuthor text not null,
        $columnTime text not null,
        $columnThumb text,
        $columnTitle text not null)
      ''';
  }

  tableBaseString(String name, String columnId) {
    return '''create table $name ($columnId integer primary key,''';
  }

  ///根据用户名获取用户
  Future getDatumProvider(Database db, int id) async {
    List<Map<String, dynamic>> maps = await db.query(name,
        columns: [
          columnId,
          columnTitle,
          columnThumb,
          columnTime,
          columnAuthor,
          columnClassId
        ],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      DatumDbProvider provider = DatumDbProvider.fromMap(maps.first);
      return provider;
    }
    return null;
  }

  ///插入
  Future insert(Datum datum) async {
    Database db = await getDataBase();
    var userProvider = await getDatumProvider(db, datum.id);
    if (userProvider != null) {
      await db.delete(name, where: "$columnId = ?", whereArgs: [datum.id]);
    }
    return await db.insert(name, toMap(datum));
  }
  ///插入
  Future delete(Datum datum) async {
    Database db = await getDataBase();
    var datumProvider = await getDatumProvider(db, datum.id);
    int res=0;
    if (datumProvider != null) {
     res= await db.delete(name, where: "$columnId = ?", whereArgs: [datum.id]);
    }
    return res;
  }
  Future<Datum> getDatumInfo(int id) async {
    Database db = await getDataBase();
    DatumDbProvider datumProVider = await getDatumProvider(db, id);
    if (datumProVider != null) {
      return Datum(
          id: datumProVider.id,
          title: datumProVider.title,
          classId: datumProVider.classId,
          author: datumProVider.author,
          time: datumProVider.time,
          thumb: datumProVider.thumb);
    }
    return null;
  }

  ///根据用户名获取用户
  Future getAllDatumProvider() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await db.query(name, columns: [
      columnId,
      columnTitle,
      columnThumb,
      columnTime,
      columnAuthor,
      columnClassId
    ]);
    List<Datum> datums = List();
    for (int i = 0; i < maps.length; i++) {
      DatumDbProvider provider = DatumDbProvider.fromMap(maps[i]);
      datums.add(Datum(
          id: provider.id,
          title: provider.title,
          classId: provider.classId,
          author: provider.author,
          time: provider.time,
          thumb: provider.thumb));
    }
    return datums;
  }
}
class DatumDbProviderOfHistry extends DemoBaseDbProvider {
  final String name = 'DatumOfHistry'; //表名
  final String columnId = '_id';
  final String columnTitle = 'title';
  final String columnClassId = 'classId';
  final String columnAuthor = 'author';
  final String columnTime = 'time';
  final String columnThumb = 'thumb';
  int id;
  String title;
  int classId;
  String author;
  String time;
  String thumb;

  DatumDbProviderOfHistry();

  Map<String, dynamic> toMap(Datum datum) {
    Map<String, dynamic> map = {
      columnId: datum.id,
      columnTitle: datum.title,
      columnClassId: datum.classId,
      columnAuthor: datum.author,
      columnTime: datum.time,
      columnThumb: datum.thumb
    };
    return map;
  }

  DatumDbProviderOfHistry.fromMap(Map map) {
    id = map[columnId];
    title = map[columnTitle];
    thumb = map[columnThumb];
    time = map[columnTime];
    author = map[columnAuthor];
    classId = map[columnClassId];
  }

  @override
  tableName() {
    return name;
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
        $columnClassId integer,
        $columnAuthor text not null,
        $columnTime text not null,
        $columnThumb text,
        $columnTitle text not null)
      ''';
  }

  tableBaseString(String name, String columnId) {
    return '''create table $name ($columnId integer primary key,''';
  }

  ///根据用户名获取用户
  Future getDatumProvider(Database db, int id) async {
    List<Map<String, dynamic>> maps = await db.query(name,
        columns: [
          columnId,
          columnTitle,
          columnThumb,
          columnTime,
          columnAuthor,
          columnClassId
        ],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      DatumDbProvider provider = DatumDbProvider.fromMap(maps.first);
      return provider;
    }
    return null;
  }

  ///插入
  Future insert(Datum datum) async {
    Database db = await getDataBase();
    var userProvider = await getDatumProvider(db, datum.id);
    if (userProvider != null) {
      await db.delete(name, where: "$columnId = ?", whereArgs: [datum.id]);
    }
    return await db.insert(name, toMap(datum));
  }
  ///插入
  Future delete(Datum datum) async {
    Database db = await getDataBase();
    var datumProvider = await getDatumProvider(db, datum.id);
    int res=0;
    if (datumProvider != null) {
      res= await db.delete(name, where: "$columnId = ?", whereArgs: [datum.id]);
    }
    return res;
  }
  Future<Datum> getDatumInfo(int id) async {
    Database db = await getDataBase();
    DatumDbProvider datumProVider = await getDatumProvider(db, id);
    if (datumProVider != null) {
      return Datum(
          id: datumProVider.id,
          title: datumProVider.title,
          classId: datumProVider.classId,
          author: datumProVider.author,
          time: datumProVider.time,
          thumb: datumProVider.thumb);
    }
    return null;
  }

  ///根据用户名获取用户
  Future getAllDatumProvider() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await db.query(name, columns: [
      columnId,
      columnTitle,
      columnThumb,
      columnTime,
      columnAuthor,
      columnClassId
    ]);
    List<Datum> datums = List();
    for (int i = 0; i < maps.length; i++) {
      DatumDbProvider provider = DatumDbProvider.fromMap(maps[i]);
      datums.add(Datum(
          id: provider.id,
          title: provider.title,
          classId: provider.classId,
          author: provider.author,
          time: provider.time,
          thumb: provider.thumb));
    }
    return datums;
  }
}