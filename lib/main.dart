import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toka/config/Routes.dart';
import 'package:toka/config/Theme.dart';

import 'provider/GlobalProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GlobalProvider>(
          create: (_) => GlobalProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Toka Users',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: routes,
        initialRoute: "login",
        theme: principalTheme,
      ),
    );
  }
}
