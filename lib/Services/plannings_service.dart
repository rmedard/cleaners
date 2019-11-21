import 'dart:convert';

import 'package:cleaners/Services/auth_service.dart';
import 'package:cleaners/constants.dart';
import 'package:cleaners/models/planning.dart';
import 'package:http/http.dart';

class PlanningsService {
  final String apiUrl = kApiUrl;
  final AuthService _authService = AuthService();

  Future<List<Planning>> getPlannings() async {
    var url = '$apiUrl/plannings';
    return _authService.getLoggedInUser().then((loggedInUser) async {
      List<Planning> plannings = [];
      if (loggedInUser != null) {
        await get(url, headers: loggedInUser.headers).then((response) {
          if (response.statusCode == 200) {
            List<dynamic> data = jsonDecode(response.body);
            plannings =
                data.map((dynamic item) => Planning.fromJson(item)).toList();
          }
        });
      }
      return plannings;
    });
  }
}
