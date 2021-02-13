import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toka/config/Routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        title: 'Toka Users',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: routes,
        initialRoute: "login",
      ),
    );
  }
}
