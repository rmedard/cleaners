import 'dart:convert';

import 'package:cleaners/constants.dart';
import 'package:cleaners/models/dto/logged_in_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class AuthNotifier extends ChangeNotifier {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  LoggedInUser _loggedInUser;

  Future<void> login(String email, String password) async {
    var url = '$kApiUrl/auth/login';
    Response response =
        await post(url, body: {'Username': email.trim(), 'Password': password.trim()});
    if (response.statusCode == 200) {
      Map<String, dynamic> user = jsonDecode(response.body);
      _loggedInUser = LoggedInUser.fromJson(user);
      _storage
          .write(key: kLoggedInUser, value: jsonEncode(_loggedInUser.toJson()))
          .whenComplete(() => notifyListeners());
    } else {
      _loggedInUser = null;
      _storage.delete(key: kLoggedInUser).whenComplete(() => notifyListeners());
    }
  }

  Future<void> logout() {
    return _storage.delete(key: kLoggedInUser).whenComplete(() {
      _loggedInUser = null;
      notifyListeners();
    });
  }

  LoggedInUser get loggedInUser {
    if (_loggedInUser == null) {
      _storage.read(key: kLoggedInUser).then((userJson) {
        _loggedInUser = userJson != null
            ? LoggedInUser.fromJson(jsonDecode(userJson))
            : null;
      }).whenComplete(() => notifyListeners());
    }
    return _loggedInUser;
  }
}
