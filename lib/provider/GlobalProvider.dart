import 'package:toka/provider/DatabaseProvider.dart';

class GlobalProvider {
  DatabaseProvider databaseProvider;

  GlobalProvider() {
    databaseProvider = new DatabaseProvider();
  }
}
