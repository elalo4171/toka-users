import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toka/model/PersonModel.dart';
import 'package:toka/model/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:toka/util/Util.dart';

class DatabaseProvider {
  Database _database;
  BehaviorSubject isLogged = BehaviorSubject<bool>();
  static final _databaseName = "database.db";
  static final _databaseVersion = 1;
  static final _tableUser = 'user';
  static final _columnIdUser = 'id';
  static final _columnEmailUser = 'email';
  static final _columnPasswordUser = 'password';
  static final _usersToLoad = 10;

  DatabaseProvider() {
    _initDatabase();
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    _database = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
    bool isLoggedBool = await isUserLogged();
    isLogged.sink.add(isLoggedBool);
    await loadFirstUsers();
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
    await db.execute('''
          CREATE TABLE person (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            picture TEXT NOT NULL,
            email TEXT NOT NULL,
            ranking INTEGER NOT NULL,
            street TEXT NOT NULL,
            city TEXT NOT NULL,
            state TEXT NOT NULL,
            postcode TEXT NOT NULL,
            cell TEXT NOT NULL,
            latitude TEXT NOT NULL,
            longitude TEXT NOT NULL
          )
          ''');
    await db.insert(
      _tableUser,
      User(email: "z@z.com", password: "123456").toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> loadFirstUsers() async {
    int count = Sqflite.firstIntValue(
        await _database.rawQuery('SELECT COUNT(*) FROM person'));
    if (count < 1) {
      Uri uri = new Uri.https(
        "randomuser.me",
        "api",
        {"results": _usersToLoad.toString()},
      );
      Response response = await http.get(
        uri,
      );
      if (response.statusCode == 200) {
        Map body = json.decode(response.body);
        List<Person> persons =
            List<Person>.from(body["results"].map((x) => Person.fromJson(x)));
        persons.forEach((element) async {
          element.ranking = Util().ranking();
          await _database.insert("person", element.toJsonDatabase());
        });
      }
    }
  }

  Future<void> updatePerson(Person person) async {
    await _database.update("person", person.toJsonDatabase(),
        where: "id = ?", whereArgs: [person.id]);
  }

  Future<List<Person>> getPersons() async {
    var data = await _database.query(
      "person",
    );
    List<Person> persons =
        List<Person>.from(data.map((x) => Person.fromJsonDatabase(x)));
    return persons;
  }

  Future<bool> isUserLogged() async {
    int count = Sqflite.firstIntValue(
        await _database.rawQuery('SELECT COUNT(*) FROM logged'));
    print(count);
    return count > 0;
  }

  Future<int> insertUser(User user) async {
    return await _database.insert(_tableUser, user.toJson());
  }

  Future<int> insertUserLogged(int id) async {
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

  closeSessions(BuildContext context) {
    cleanUserLogged();
    Navigator.pushReplacementNamed(context, "login");
  }

  close() {
    isLogged.close();
  }
}
