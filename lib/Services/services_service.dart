import 'dart:convert';

import 'package:cleaners/constants.dart';
import 'package:cleaners/models/expertise.dart';
import 'package:cleaners/models/service.dart';
import 'package:http/http.dart';

class ServicesService {
  final String apiUrl = kApiUrl;

  Future<List<Service>> getAllServices() async {
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

  Future<Service> getServiceById({int serviceId}) async {
    var url = '$apiUrl/services/$serviceId';
    Response response = await get(url);
    Service service;
    if (response.statusCode == 200) {
      service = Service.fromJson(jsonDecode(response.body));
    }
    return service;
  }

  Future<List<Expertise>> getExpertises({int serviceId}) async {
    var url = serviceId != null
        ? '$apiUrl/expertises?serviceId=$serviceId'
        : '$apiUrl/expertises';
    List<Expertise> expertises = [];
    Response response = await get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      data.forEach((expertise) {
        expertises.add(Expertise.fromJson(expertise as Map<String, dynamic>));
      });
    }
    return expertises;
  }
}
