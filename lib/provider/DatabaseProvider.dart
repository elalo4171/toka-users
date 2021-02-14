import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toka/model/UserModel.dart';

class DatabaseProvider {
  static final _databaseName = "database.db";
  static final _databaseVersion = 1;
  static final _tableUser = 'user';
  static final _columnIdUser = 'id';
  static final _columnEmailUser = 'email';
  static final _columnPasswordUser = 'password';
  Database _database;

  DatabaseProvider() {
    _initDatabase();
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    _database = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_tableUser (
            $_columnIdUser INTEGER PRIMARY KEY,
            $_columnEmailUser TEXT NOT NULL,
            $_columnPasswordUser TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE logged (
            id INTEGER PRIMARY KEY,
            user_id INTEGER NOT NULL,
            FOREIGN KEY(user_id) REFERENCES user($_columnIdUser)
          )
          ''');
    await db.insert(
      _tableUser,
      User(email: "z@z.com", password: "123456").toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertUser(User user) async {
    return await _database.insert(_tableUser, user.toJson());
  }

  Future<void> insertUserLogged(int id) async {
    return await _database.insert(
      'logged',
      {'user_id': id},
    );
  }

  Future<void> cleanUserLogged() async {
    _database.delete("logged");
  }

  Future<bool> validateUser(User user) async {
    User userDatabase = await getUserByEmail(user.email);
    if (userDatabase != null) {
      if (userDatabase.password == user.password) {
        await cleanUserLogged();
        await insertUserLogged(userDatabase.id);
        return true;
      }
    }
    return false;
  }

  Future<User> getUserByEmail(String email) async {
    try {
      List<Map> userDatabase = await _database.query(_tableUser,
          columns: [_columnIdUser, _columnEmailUser, _columnPasswordUser],
          where: '$_columnEmailUser = ?',
          whereArgs: [email]);
      if (userDatabase.length > 0) {
        return User.fromJson(userDatabase[0]);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
