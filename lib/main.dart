import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toka/config/Routes.dart';
import 'package:toka/config/Theme.dart';
import 'provider/DatabaseProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DatabaseProvider>(
          create: (_) => DatabaseProvider(),
        ),
      ],
      child: Consumer<DatabaseProvider>(
        builder: (context, provider, _) {
          return StreamBuilder(
            stream: provider.isLogged,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return MateApp(
                  isLogged: snapshot.data,
                );
              }
              return MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MateApp extends StatelessWidget {
  const MateApp({
    Key key,
    this.isLogged,
  }) : super(key: key);
  final bool isLogged;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toka Users',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routes,
      initialRoute: isLogged ? "home" : "login",
      theme: principalTheme,
    );
  }
}
