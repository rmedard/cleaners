import 'package:cleaners/models/person.dart';

class LoggedInUser {
  String token;
  User user;

  LoggedInUser();

  LoggedInUser.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = User.fromJson(json['user']);

  Map<String, dynamic> toJson() => {'token': token, 'user': user.toJson()};
}

class User {
  int id;
  String username;
  List<String> roles;
  Person person;
  int customerId;
  int professionalId;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        roles =
            (json['roles'] as List<dynamic>).map((e) => e.toString()).toList(),
        person = Person.fromJson(json['person']),
        customerId = json['customerId'],
        professionalId = json['professional'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'roles': roles,
        'person': person.toJson(),
        'customerId': customerId,
        'professionalId': professionalId
      };
}
