import 'dart:convert';

import 'package:cleaners/Services/auth_service.dart';
import 'package:cleaners/Services/services_service.dart';
import 'package:cleaners/constants.dart';
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
    LoggedInUser loggedInUser = await _authService.getLoggedInUser();
    List<PlanningDto> wholePlannings = [];
    if (loggedInUser != null) {
      final response = await get(url, headers: loggedInUser.headers);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Planning> plannings =
            data.map((dynamic item) => Planning.fromJson(item)).toList();
        Set<int> serviceIds =
            plannings.map((Planning plan) => plan.serviceId).toSet();
        serviceIds.forEach((id) async {
          Service service = await _servicesService.getServiceById(id);
          print('Service found: ${service.name}');
          plannings
              .where((pl) => pl.serviceId == service.id)
              .forEach((planning) {
            Professional professional = service.professionals
                .firstWhere((p) => p.id == planning.professionalId);
            print('Prof found: ${professional.lastName}');
            wholePlannings.add(PlanningDto(
                planning: planning,
                service: service,
                professional: professional));
          });
        });
        wholePlannings.sort(
            (a, b) => b.planning.startTime().compareTo(a.planning.startTime()));
      }
    }
//    print('Plannings size: ${wholePlannings.length}');
    return wholePlannings;
  }
}
