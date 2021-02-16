import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toka/config/Theme.dart';
import 'package:toka/model/PersonModel.dart';
import 'package:toka/provider/DatabaseProvider.dart';
import 'package:toka/provider/EditPersonProvider.dart';
import 'package:toka/widgets/InputText.dart';

class EditPersonPage extends StatelessWidget {
  const EditPersonPage({Key key, this.person}) : super(key: key);
  final Person person;
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => EditPersonProvider(person),
      builder: (context, child) => Scaffold(
        body: _EditPersonBuild(
          person: person,
        ),
      ),
    );
  }
}

class _EditPersonBuild extends StatelessWidget {
  const _EditPersonBuild({
    Key key,
    this.person,
  }) : super(key: key);
  final Person person;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    final EditPersonProvider editPersonProvider =
        context.read<EditPersonProvider>();
    final DatabaseProvider databaseProvider = context.read<DatabaseProvider>();

    return Scaffold(
        backgroundColor: TokaTheme.primary,
        appBar: AppBar(
          title: Text("Editar persona", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: editPersonProvider.form,
            child: ListView(
              children: [
                SizedBox(height: 20),
                InputText(
                  hint: "Nombre",
                  subject: editPersonProvider.name,
                  initialValue: person.name.first,
                  label: "Nombre",
                  validator: editPersonProvider.requiredField,
                ),
                SizedBox(height: 20),
                InputText(
                  hint: "Correo",
                  subject: editPersonProvider.email,
                  initialValue: person.email,
                  label: "Correo",
                  validator: editPersonProvider.validateEmail,
                ),
                SizedBox(height: 20),
                InputText(
                  hint: "Calle",
                  subject: editPersonProvider.street,
                  initialValue: person.location.street.name,
                  label: "Calle",
                  validator: editPersonProvider.requiredField,
                ),
                SizedBox(height: 20),
                InputText(
                  hint: "Ciudad",
                  subject: editPersonProvider.city,
                  initialValue: person.location.city,
                  label: "Ciudad",
                  validator: editPersonProvider.requiredField,
                ),
                SizedBox(height: 20),
                InputText(
                  hint: "Estado",
                  subject: editPersonProvider.state,
                  initialValue: person.location.state,
                  label: "Estado",
                  validator: editPersonProvider.requiredField,
                ),
                SizedBox(height: 20),
                InputText(
                  hint: "Codigo postal",
                  subject: editPersonProvider.postcode,
                  initialValue: person.location.postcode,
                  label: "Codigo postal",
                  validator: editPersonProvider.requiredField,
                ),
                SizedBox(height: 20),
                InputText(
                  hint: "Celular",
                  subject: editPersonProvider.cell,
                  initialValue: person.cell,
                  label: "Celular",
                  validator: editPersonProvider.requiredField,
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: size.size.width * .7,
                    child: RaisedButton(
                      onPressed: () async {
                        if (editPersonProvider.form.currentState.validate()) {
                          Person person = await editPersonProvider
                              .updateLocalPerson(databaseProvider);

                          if (person != null) {
                            Navigator.pop(context, person);
                          }
                        } else {}
                      },
                      child: Text(
                        "Guardar",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
