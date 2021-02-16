class Person {
  Person({
    this.id,
    this.name,
    this.location,
    this.email,
    this.phone,
    this.cell,
    this.picture,
    this.ranking,
  });

  int id;
  String gender;
  Name name;
  Location location;
  String email;
  String phone;
  String cell;
  String picture;
  double ranking;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        name: Name.fromJson(json["name"]),
        location: Location.fromJson(json["location"]),
        email: json["email"],
        phone: json["phone"],
        cell: json["cell"],
        picture: json["picture"]['medium'],
        ranking: json["ranking"],
      );
  factory Person.fromJsonDatabase(Map<String, dynamic> json) => Person(
        id: json['id'],
        name: Name(first: json["name"]),
        location: Location(
            city: json["city"],
            postcode: json["postcode"],
            state: json["state"],
            street: Street(
              name: json["street"],
            ),
            coordinates: Coordinates(
                latitude: json["latitude"], longitude: json["longitude"])),
        email: json["email"],
        phone: json["phone"],
        cell: json["cell"],
        picture: json["picture"],
        ranking: double.parse(json["ranking"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "name": name.toJson(),
        "picture": picture,
        "email": email,
        "phone": phone,
        "cell": cell,
        "ranking": ranking,
        "location": location.toJson(),
      };
  Map<String, dynamic> toJsonDatabase() => {
        "name": "${name.first} ${name.last ?? ""}",
        "picture": picture,
        "email": email,
        "ranking": ranking,
        "street": '${location.street.number} ${location.street.name}',
        "city": location.city,
        "state": location.state,
        "postcode": location.postcode,
        "cell": cell,
        "latitude": location.coordinates.latitude,
        "longitude": location.coordinates.longitude,
      };
}

class Location {
  Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.coordinates,
  });

  Street street;
  String city;
  String state;
  String country;
  String postcode;
  Coordinates coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        street: Street.fromJson(json["street"]),
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postcode: json["postcode"].toString(),
        coordinates: Coordinates.fromJson(json["coordinates"]),
      );

  Map<String, dynamic> toJson() => {
        "street": street.toJson(),
        "city": city,
        "state": state,
        "country": country,
        "postcode": postcode,
        "coordinates": coordinates.toJson(),
      };
}

class Coordinates {
  Coordinates({
    this.latitude,
    this.longitude,
  });

  String latitude;
  String longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Street {
  Street({
    this.number,
    this.name,
  });

  int number;
  String name;

  factory Street.fromJson(Map<String, dynamic> json) => Street(
        number: json["number"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
      };
}

class Name {
  Name({
    this.title,
    this.first,
    this.last,
  });

  String title;
  String first;
  String last;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        title: json["title"],
        first: json["first"],
        last: json["last"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "first": first,
        "last": last,
      };
}
