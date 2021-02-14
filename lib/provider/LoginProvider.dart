import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toka/model/UserModel.dart';
import 'package:toka/util/Validator.dart';

import 'GlobalProvider.dart';

class LoginProvider with Validator {
  BehaviorSubject<String> email = BehaviorSubject<String>();
  BehaviorSubject<String> password = BehaviorSubject<String>();
  BehaviorSubject<String> error = BehaviorSubject<String>();
  final form = GlobalKey<FormState>();

  Future<void> login(
      GlobalProvider globalProvider, BuildContext context) async {
    User user = User(email: email.value, password: password.value);
    bool isValidate = await globalProvider.databaseProvider.validateUser(user);
    if (isValidate) {
      Navigator.pushReplacementNamed(context, "home");
    } else {
      error.sink.add("Datos incorrectos");
    }
  }

  void close() {
    email.close();
    password.close();
    error.close();
  }
}
