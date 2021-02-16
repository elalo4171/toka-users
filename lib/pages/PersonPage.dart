import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toka/config/Theme.dart';
import 'package:toka/model/PersonModel.dart';
import 'package:toka/pages/EditPersonPage.dart';
import 'package:toka/widgets/ImageToka.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key key, @required this.person}) : super(key: key);
  final Person person;

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  Person person;
  @override
  void initState() {
    person = widget.person;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
            title: Text("Detalles de contacto",
                style: TextStyle(color: Colors.white)),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(FontAwesomeIcons.userEdit),
                    onPressed: () async {
                      Person p = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPersonPage(
                              person: person,
                            ),
                          ));
                      if (p != null) {
                        this.person = p;
                        setState(() {});
                      }
                    }),
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _PersonDetails(person: person),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Direccion:"),
                ],
              ),
              SizedBox(height: 10),
              _AddressDetails(
                  title: "Calle: ", value: person.location.street.name),
              SizedBox(height: 10),
              _AddressDetails(title: "Ciudad: ", value: person.location.city),
              SizedBox(height: 10),
              _AddressDetails(title: "Estado: ", value: person.location.state),
              SizedBox(height: 10),
              _AddressDetails(
                  title: "Codigo: ", value: person.location.postcode),
              SizedBox(height: 10),
              _AddressDetails(title: "Telefono: ", value: person.cell),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text("Ubicacion"),
                ],
              ),
              SizedBox(height: 20),
              Container(
                  height: size.size.height * .2,
                  child: _Map(
                    location: LatLng(
                        double.parse(person.location.coordinates.latitude),
                        double.parse(person.location.coordinates.longitude)),
                  )),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: size.size.width * .7,
                  child: RaisedButton(
                    onPressed: () async {
                      if (await canLaunch("tel:${person.cell}")) {
                        await launch("tel:${person.cell}");
                      } else {}
                    },
                    child: Text(
                      "Contactar",
                      style: theme.textTheme.button,
                    ),
                    color: TokaTheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }
}

class _Map extends StatelessWidget {
  const _Map({
    Key key,
    @required this.location,
  }) : super(key: key);
  final LatLng location;

  @override
  Widget build(BuildContext context) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(location.latitude, location.longitude),
      zoom: 14.4746,
    );
    return Container(
      child: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.from([
          Marker(
              markerId: MarkerId(location.latitude.toString()),
              position: location)
        ]),
        onMapCreated: (GoogleMapController controller) {},
      ),
    );
  }
}

class _AddressDetails extends StatelessWidget {
  const _AddressDetails({
    Key key,
    @required this.title,
    this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          title,
          style: theme.textTheme.subtitle1,
        ),
        Text(value, style: theme.textTheme.bodyText1)
      ],
    );
  }
}

class _PersonDetails extends StatelessWidget {
  const _PersonDetails({
    Key key,
    @required this.person,
  }) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(person.name.first),
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
              Row(
                  children: List.generate(
                person.ranking.toInt(),
                (index) => Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(person.ranking.toString()),
              )
            ],
          )
        ],
      ),
      isThreeLine: true,
      leading: ImageToka(person: person),
    );
  }
}
