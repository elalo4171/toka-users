import 'package:flutter/material.dart';
import 'package:toka/provider/DatabaseProvider.dart';

class GlobalProvider {
  DatabaseProvider databaseProvider;

  GlobalProvider() {
    databaseProvider = new DatabaseProvider();
  }

  closeSessions(BuildContext context) {
    databaseProvider.cleanUserLogged();
    Navigator.pushReplacementNamed(context, "login");
  }
}
