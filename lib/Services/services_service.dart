import 'dart:convert';

import 'package:cleaners/Services/auth_service.dart';
import 'package:cleaners/constants.dart';
import 'package:cleaners/models/service.dart';
import 'package:http/http.dart';

class ServicesService {
  final String apiUrl = kApiUrl;
  final AuthService _authService = AuthService();

  Future<List<Service>> getServices() async {
    var url = '$apiUrl/services';
    List<Service> services = [];
    Response response = await get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      data.forEach((service) {
        services.add(Service.fromJson(service as Map<String, dynamic>));
      });
    }
    return services;
  }

  Future<Service> getService(Service service) async {
    var url = '$apiUrl/services/${service.id}';
    Response response = await get(url);
    Service serviceObj;
    if (response.statusCode == 200) {
      serviceObj =
          Service.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      serviceObj.category = service.category;
      _authService.getLoggedInUser().then((user) {
        if (user != null) {
          serviceObj.professionals.removeWhere((p) => p.id == user.person.id);
        }
      });
    }
    return serviceObj;
  }

  Future<Service> getServiceById(int serviceId) async {
    var url = '$apiUrl/services/$serviceId';
    Response response = await get(url);
    Service serviceObj;
    if (response.statusCode == 200) {
      serviceObj =
          Service.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      _authService.getLoggedInUser().then((user) {
        if (user != null) {
          serviceObj.professionals.removeWhere((p) => p.id == user.person.id);
        }
      });
    }
    return serviceObj;
  }
}
