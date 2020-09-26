import 'dart:convert';

import 'package:cleaners/models/professional.dart';
import 'package:http/http.dart';

import '../constants.dart';

class ProfessionalsService {

  final String apiUrl = kApiUrl;

  Future<Professional> getProfessionalByUserId({int professionalId}) async {
    var url = '$apiUrl/professionals/userId/$professionalId';
    var professional;
    Response response = await get(url);
    if (response.statusCode == 200) {
      professional = Professional.fromJson(jsonDecode(response.body));
    }
    return professional;
  }
}