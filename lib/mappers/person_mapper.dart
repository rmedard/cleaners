import 'package:cleaners/models/person.dart';

class PersonMapper {
  Person map(Map<String, dynamic> user) {
    return Person(
        user['id'],
        user['email'],
        user['type_id'],
        user['first_name'],
        user['last_name'],
        user['phone_number'],
        user['plot_number'],
        user['street_name'],
        user['city_name'],
        user['post_code'],
        user['picture']);
  }
}
