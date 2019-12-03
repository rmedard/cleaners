import 'package:cleaners/models/planning.dart';
import 'package:cleaners/models/professional.dart';
import 'package:cleaners/models/service.dart';
import 'package:cleaners/utils/date_utils.dart';

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

  double getTotalCost() {
    String startHour = DateUtils.dateToString(planning.startTime(), 'HH');
    String endHour = DateUtils.dateToString(planning.endTime(), 'HH');
    return (int.parse(endHour) - int.parse(startHour)) * professional.price;
  }
}