import 'package:cleaners/models/person.dart';

class LoggedInUser {
  Person person;
  Map<String, String> headers;

  LoggedInUser();

  Map<String, dynamic> toJson() =>
      {'person': person.toJson(), 'headers': headers};

  LoggedInUser.fromJson(Map<String, dynamic> json)
      : headers = Map<String, String>.from(json['headers']),
        person = Person.fromJson(json['person']);
}
