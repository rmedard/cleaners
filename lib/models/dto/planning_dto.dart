import 'package:cleaners/models/planning.dart';
import 'package:cleaners/models/professional.dart';
import 'package:cleaners/models/service.dart';

class PlanningDto {
  Planning planning;
  Professional professional;
  Service service;

  PlanningDto({this.planning, this.professional, this.service});

  Map<String, dynamic> toJson() => {
    'planning': planning.toJson(),
    'professional': professional.toJson(),
    'service': service.toJson()
  };
}