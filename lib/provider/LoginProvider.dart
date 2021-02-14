import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toka/model/UserModel.dart';
import 'package:toka/util/Validator.dart';
import 'package:local_auth/local_auth.dart';
import 'GlobalProvider.dart';

class LoginProvider with Validator {
  LoginProvider() {
    checkAuth();
  }

  BehaviorSubject<String> email = BehaviorSubject<String>();
  BehaviorSubject<String> password = BehaviorSubject<String>();
  BehaviorSubject<String> error = BehaviorSubject<String>();
  BehaviorSubject<bool> authBiometrics = BehaviorSubject<bool>();
  final form = GlobalKey<FormState>();
  final LocalAuthentication auth = LocalAuthentication();

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

  checkAuth() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();

      if (Platform.isIOS) {
        if (availableBiometrics.contains(BiometricType.face)) {
          // Face ID.
          authBiometrics.sink.add(true);
        } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
          // Touch ID.
          authBiometrics.sink.add(true);
        }
      }
    }
  }

  loginWithBiometrics(BuildContext context) async {
    bool didAuthenticate =
        await auth.authenticateWithBiometrics(localizedReason: 'Inicia sesion');
    if (didAuthenticate) {
      Navigator.pushReplacementNamed(context, "home");
    }
  }

  void close() {
    email.close();
    password.close();
    error.close();
    authBiometrics.close();
  }
}
