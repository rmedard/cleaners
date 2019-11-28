import 'dart:convert';

import 'package:cleaners/constants.dart';
import 'package:cleaners/models/professional.dart';
import 'package:cleaners/models/service.dart';
import 'package:http/http.dart';

class ServicesService {
  final String apiUrl = kApiUrl;

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
    if (response.statusCode == 200) {
      service.professionals = [];
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> professionals = data['professionals'];
      professionals.forEach((p) {
        service.professionals.add(Professional.fromJson(p as Map<String, dynamic>));
      });
    }
    return service;
  }

  Future<Service> getServiceById(int serviceId) async {
    var url = '$apiUrl/services/$serviceId';
    Response response = await get(url);
    Service service;
    if (response.statusCode == 200) {
      service =
          Service.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    return service;
  }
}
