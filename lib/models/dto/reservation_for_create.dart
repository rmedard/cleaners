import 'package:cleaners/utils/date_utils.dart';
import 'package:flutter/cupertino.dart';

class ReservationForCreate {
  int customerId;
  ExpertiseForServiceCreate expertiseForServiceCreate;
  DateTime startTime;
  int duration;

  ReservationForCreate.create(
      {@required this.customerId,
      @required this.expertiseForServiceCreate,
      @required this.startTime,
      @required this.duration});

  Map<String, dynamic> toJson() => {
        'customerId': customerId,
        'expertiseForServiceCreate': expertiseForServiceCreate,
        'startTime': DateUtils.dateToString(startTime, "y-M-d HH:mm:ss"),
        'duration': duration
      };
}

class ExpertiseForServiceCreate {
  int professionalId;
  int serviceId;

  ExpertiseForServiceCreate.create(
      {@required this.professionalId, @required this.serviceId});

  Map<String, dynamic> toJson() =>
      {'professionalId': professionalId, 'serviceId': serviceId};
}
