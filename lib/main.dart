import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toka/config/Routes.dart';
import 'package:toka/config/Theme.dart';
import 'package:toka/provider/LoginProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginProvider>(create: (_)=>LoginProvider(),)
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
