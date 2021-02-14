class User {
  User({
    this.id,
    this.email,
    this.password,
  });

  int id;
  String email;
  String password;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
