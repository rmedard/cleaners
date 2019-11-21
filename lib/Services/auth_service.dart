import 'dart:convert';

import 'package:cleaners/constants.dart';
import 'package:cleaners/models/dto/logged_in_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String apiUrl = kApiUrl;
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<LoggedInUser> getLoggedInUser() async {
    var userJson = await storage.read(key: kLoggedInUser);
    if (userJson != null) {
      return LoggedInUser.fromJson(jsonDecode(userJson));
    } else {
      return null;
    }
  }
}
