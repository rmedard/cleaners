import 'package:cleaners/models/planning.dart';
import 'package:cleaners/models/professional.dart';
import 'package:cleaners/models/service.dart';

class PlanningDto {
  Planning planning;
  Professional professional;
  Service service;

  PlanningDto({this.planning, this.professional, this.service});

}