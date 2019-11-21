import 'dart:convert';

import 'package:cleaners/constants.dart';
import 'package:cleaners/mappers/person_mapper.dart';
import 'package:cleaners/models/dto/logged_in_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class AuthNotifier extends ChangeNotifier {
  final PersonMapper _personMapper = PersonMapper();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  LoggedInUser _loggedInUser;

  Future<void> login(String email, String password) async {
    var url = '$kApiUrl/personas/sign_in';
    _loggedInUser = LoggedInUser();
    Response response =
        await post(url, body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      Map<String, dynamic> user = jsonDecode(response.body);
      _loggedInUser.person = _personMapper.map(user['data']);
      _loggedInUser.headers = new Map();
      _loggedInUser.headers.putIfAbsent(kHeaders[headerType.accessToken], () {
        return response.headers[kHeaders[headerType.accessToken]];
      });
      _loggedInUser.headers.putIfAbsent(kHeaders[headerType.tokenType], () {
        return response.headers[kHeaders[headerType.tokenType]];
      });
      _loggedInUser.headers.putIfAbsent(kHeaders[headerType.client], () {
        return response.headers[kHeaders[headerType.client]];
      });
      _loggedInUser.headers.putIfAbsent(kHeaders[headerType.expiry], () {
        return response.headers[kHeaders[headerType.expiry]];
      });
      _loggedInUser.headers.putIfAbsent(kHeaders[headerType.uid], () {
        return response.headers[kHeaders[headerType.uid]];
      });
      _storage.write(
          key: kLoggedInUser, value: jsonEncode(_loggedInUser.toJson()));
    } else {
      _storage.delete(key: kLoggedInUser);
      _loggedInUser = null;
    }
    notifyListeners();
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
