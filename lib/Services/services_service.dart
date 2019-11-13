import 'dart:convert';

import 'package:cleaners/constants.dart';
import 'package:cleaners/mappers/service_mapper.dart';
import 'package:cleaners/models/service.dart';
import 'package:http/http.dart';

class ServicesService {
  final String apiUrl = kApiUrl;
  final ServiceMapper serviceMapper = new ServiceMapper();

  Future<List<Service>> getServices() async {
    var url = '$apiUrl/services';
    List<Service> services = [];
    Response response = await get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      data.forEach((service){
        Map<String, dynamic> s = service;
        services.add(serviceMapper.map(s));
      });
    }
    return services;
  }
}
