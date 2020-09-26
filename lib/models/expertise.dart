import 'package:cleaners/models/professional.dart';
import 'package:cleaners/models/service.dart';

class Expertise {
  int id;
  int serviceId;
  int professionalId;
  double hourlyRate;
  Service service;
  Professional professional;

  Expertise.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        serviceId = json['serviceId'],
        professionalId = json['professionalId'],
        service = json['service'] == null ? null : Service.fromJson(json['service']),
        hourlyRate = json['hourlyRate'],
        professional = json['professional'] == null ? null : Professional.fromJson(json['professional']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'serviceId': serviceId,
        'professionalId': professionalId,
        'hourlyRate': hourlyRate,
        'service': service.toJson()
      };
}
