import 'package:rxdart/rxdart.dart';
import 'package:toka/model/PersonModel.dart';
import 'package:toka/provider/DatabaseProvider.dart';

class EditPersonProvider {
  BehaviorSubject name = BehaviorSubject<String>();
  BehaviorSubject email = BehaviorSubject<String>();
  BehaviorSubject street = BehaviorSubject<String>();
  BehaviorSubject city = BehaviorSubject<String>();
  BehaviorSubject state = BehaviorSubject<String>();
  BehaviorSubject postcode = BehaviorSubject<String>();
  BehaviorSubject cell = BehaviorSubject<String>();

  Person person;
  EditPersonProvider(Person p) {
    person = p;
    name.sink.add(person.name.first);
    street.sink.add(person.location.street.name);
    email.sink.add(person.email);
    state.sink.add(person.location.state);
    city.sink.add(person.location.city);
    cell.sink.add(person.cell);
    postcode.sink.add(person.location.postcode);
  }

  Future<Person> updateLocalPerson(DatabaseProvider database) async {
    person.name.first = name.value;
    person.location.street.name = street.value;
    person.email = email.value;
    person.location.state = state.value;
    person.location.city = city.value;
    person.cell = cell.value;
    person.location.postcode = postcode.value;
    await database.updatePerson(person);
    return person;
  }

  void close() {
    name.close();
    street.close();
    email.close();
    state.close();
    city.close();
    cell.close();
    postcode.close();
  }
}
