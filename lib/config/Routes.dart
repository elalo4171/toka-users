import 'package:flutter/material.dart';
import 'package:toka/pages/LoginPage.dart';

Route Function(RouteSettings) get routes => (RouteSettings settings) {
      Route route;

      switch (settings.name) {
        case "login":
          route = MaterialPageRoute(
              builder: (_) => LoginPage(),
              settings: RouteSettings(name: settings.name));
          break;
        default:
          route = MaterialPageRoute(builder: (_) => DefaultPage());
          break;
      }
      return route;
    };

class DefaultPage extends StatelessWidget {
  const DefaultPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Text("This page is a fanta-sea."),
      ),
    );
  }
}
