import 'package:cleaners/models/professional.dart';

class Service {
  int id;
  String name;
  String description;
  List<Professional> professionals;

  Service({this.id, this.name, this.description});
}
