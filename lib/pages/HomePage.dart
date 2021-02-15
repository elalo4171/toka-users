import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toka/model/PersonModel.dart';
import 'package:toka/provider/GlobalProvider.dart';
import 'package:toka/widgets/ImageToka.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalProvider = context.read<GlobalProvider>();
    return Scaffold(
        appBar: AppBar(
          title:
              Text("Lista de doctores", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(FontAwesomeIcons.signOutAlt), onPressed: () {}),
          ],
          leading: IconButton(
              icon: Icon(FontAwesomeIcons.userPlus), onPressed: () {}),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder<List<Person>>(
            future: globalProvider.databaseProvider.getPersons(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    Person person = snapshot.data[index];
                    return _PersonItem(person: person);
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}

class _PersonItem extends StatelessWidget {
  const _PersonItem({
    Key key,
    @required this.person,
  }) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "person", arguments: person),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: NameRanking(person: person),
            subtitle: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    person.email,
                    style: theme.textTheme.bodyText2,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                    ),
                    Text(person.location.street.name),
                  ],
                )
              ],
            ),
            isThreeLine: true,
            leading: ImageToka(person: person),
          ),
        ),
      ),
    );
  }
}

class NameRanking extends StatelessWidget {
  const NameRanking({
    Key key,
    @required this.person,
  }) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(person.name.first),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        Text(person.ranking.toString())
      ],
    );
  }
}
