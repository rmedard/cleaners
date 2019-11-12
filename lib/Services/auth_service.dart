import 'dart:convert';

import 'package:cleaners/constants.dart';
import 'package:cleaners/mappers/person_mapper.dart';
import 'package:cleaners/models/person.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class AuthService {
  final String apiUrl = kApiUrl;
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<Person> login(String email, String password) async {
    var url = '$apiUrl/personas/sign_in';
    PersonMapper personMapper = new PersonMapper();
    Person person;
    Response response =
        await post(url, body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      Map<String, dynamic> user = jsonDecode(response.body);
      person = personMapper.map(user['data']);
      storage.write(key: kLoggedInUser, value: jsonEncode(person.toJson()));
    } else {
      print(response);
    }
    return person;
  }
  
  Future<void> logout() {
    return storage.delete(key: kLoggedInUser);
  }

  Future<Person> getLoggedInUser() async {
    var userJson = await storage.read(key: kLoggedInUser);
    if(userJson != null) {
      return Person.fromJson(jsonDecode(userJson));
    } else {
      return null;
    }
  }
}
