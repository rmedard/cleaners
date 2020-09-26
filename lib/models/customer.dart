import 'package:cleaners/models/person.dart';

class Customer extends Person {
  int id;

  Customer.fromJson(Map<String, dynamic> json) : id = json['id'], super.fromJson(json);

}
