import 'package:flutter/material.dart';
import 'package:toka/model/PersonModel.dart';

class ImageToka extends StatelessWidget {
  const ImageToka({
    Key key,
    @required this.person,
  }) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(person.picture),
    );
  }
}
