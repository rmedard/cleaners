import 'dart:convert';

import 'package:cleaners/models/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants.dart';

class UserLoginNotifier extends ChangeNotifier {
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  Person loggedInUser;

  void getLoggedInUser() async {
    var userJson = await storage.read(key: kLoggedInUser);
    if (userJson != null) {
      loggedInUser = Person.fromJson(jsonDecode(userJson));
    } else {
      loggedInUser = null;
    }
    notifyListeners();
  }
}
