import 'package:cleaners/models/person.dart';

class Professional extends Person {

  int id;

  Professional.fromJson(Map<String, dynamic> json) : id = json['id'], super.fromJson(json);

}
