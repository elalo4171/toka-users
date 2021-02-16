import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toka/provider/DatabaseProvider.dart';
import 'package:toka/widgets/InputText.dart';

import '../config/Theme.dart';
import '../provider/LoginProvider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TokaTheme.primary,
      body: Provider(create: (context) => LoginProvider(), child: BuildLogin()),
    );
  }
}

class BuildLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DatabaseProvider databaseProvider = context.read<DatabaseProvider>();
    final LoginProvider loginProvider = context.read<LoginProvider>();
    final theme = Theme.of(context);
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Form(
        key: loginProvider.form,
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            Text("My App",
                style: theme.textTheme.headline2
                    .copyWith(color: TokaTheme.textColor)),
            Spacer(),
            InputText(
              hint: "Email",
              subject: loginProvider.email,
              validator: loginProvider.validateEmail,
            ),
            SizedBox(height: 20),
            InputText(
              hint: "Password",
              subject: loginProvider.password,
              validator: loginProvider.requiredField,
            ),
            SizedBox(height: 10),
            StreamBuilder(
              stream: loginProvider.error,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Center(
                    child: Text(snapshot.data,
                        style: TextStyle(color: theme.errorColor)),
                  );
                }
                return Container();
              },
            ),
            StreamBuilder(
                stream: loginProvider.authBiometrics,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return RaisedButton(
                        child: Text(
                          "Iniciar sesion express",
                          style: TextStyle(color: TokaTheme.primary),
                        ),
                        onPressed: () {
                          loginProvider.loginWithBiometrics(context);
                        });
                  } else
                    return Container();
                }),
            SizedBox(height: 35),
            RaisedButton(
                child: Text(
                  "Login",
                  style: TextStyle(color: TokaTheme.primary),
                ),
                onPressed: () {
                  if (loginProvider.form.currentState.validate()) {
                    loginProvider.login(databaseProvider, context);
                  }
                }),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    ));
  }
}
