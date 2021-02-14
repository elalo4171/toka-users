import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:toka/model/UserModel.dart';
import 'package:toka/widgets/InputText.dart';

import '../provider/GlobalProvider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalProvider globalProvider = context.read<GlobalProvider>();
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            Text("My App", style: theme.textTheme.headline2),
            Spacer(),
            InputText(
              hint: "Email",
              subject: BehaviorSubject(),
            ),
            SizedBox(height: 20),
            InputText(
              hint: "Password",
              subject: BehaviorSubject(),
            ),
            SizedBox(height: 40),
            RaisedButton(onPressed: () {
              globalProvider.databaseProvider
                  .validateUser(User(email: "z@z.com", password: "123456"));
            }),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      )),
    );
  }
}
