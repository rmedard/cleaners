import 'dart:convert';

import 'package:cleaners/Services/auth_service.dart';
import 'package:cleaners/Services/services_service.dart';
import 'package:cleaners/constants.dart';
import 'package:cleaners/models/dto/create_planning_dto.dart';
import 'package:cleaners/models/dto/logged_in_user.dart';
import 'package:cleaners/models/dto/planning_dto.dart';
import 'package:cleaners/models/planning.dart';
import 'package:cleaners/models/professional.dart';
import 'package:cleaners/models/service.dart';
import 'package:http/http.dart';

class PlanningsService {
  final AuthService _authService = AuthService();
  final ServicesService _servicesService = ServicesService();

  Future<List<PlanningDto>> getPlannings() async {
    var url = '$kApiUrl/plannings';
    List<PlanningDto> planningsDtos = [];
    LoggedInUser loggedInUser = await _authService.getLoggedInUser();
    if (loggedInUser != null) {
      Response response = await get(url, headers: loggedInUser.headers);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Planning> plannings = data
            .map((dynamic item) => Planning.fromJson(item))
            .where((planning) =>
                planning.customerId == loggedInUser.person.id ||
                planning.professionalId == loggedInUser.person.id)
            .toList();
        Set<int> serviceIds =
            plannings.map((Planning plan) => plan.serviceId).toSet();
        for (int serviceId in serviceIds) {
          Service service = await _servicesService.getServiceById(serviceId);
          plannings
              .where((planning) => planning.serviceId == serviceId)
              .forEach((planning) {
            Professional professional = service.professionals
                .firstWhere((p) => p.id == planning.professionalId);
            planningsDtos.add(PlanningDto(
                planning: planning,
                service: service,
                professional: professional));
          });
        }
        planningsDtos.sort(
            (a, b) => b.planning.startTime().compareTo(a.planning.startTime()));
      }
    }
    return planningsDtos;
  }

  Future<bool> createPlanning(Planning planning) async {
    LoggedInUser loggedInUser = await _authService.getLoggedInUser();
    if (loggedInUser != null) {
      String url = '$kApiUrl/plannings';
      Map<String, String> headers = loggedInUser.headers;
      headers.putIfAbsent('Content-Type', () => 'application/json');
      Response response = await post(url,
          headers: headers,
          body: jsonEncode(CreatePlanningDto(plannings: [planning])));
      if (response.statusCode == 201) {
        return true;
      }
    }
    return false;
  }
}
