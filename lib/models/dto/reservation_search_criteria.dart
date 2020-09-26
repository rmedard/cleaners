import 'package:cleaners/models/customer.dart';
import 'package:cleaners/models/professional.dart';
import 'package:cleaners/models/reservation.dart';
import 'package:enum_to_string/enum_to_string.dart';

class ReservationSearchCriteria {
  int professionalId;
  int customerId;
  Status status;
  DateTime dateTime;
  bool hasBill;

  ReservationSearchCriteria.create(
      {this.professionalId, this.customerId, this.status, this.dateTime, this.hasBill});

  Map<String, dynamic> toJson() =>
      {
        'professionalId': professionalId,
        'customerId': customerId,
        'status': EnumToString.convertToString(status),
        'dateTime': dateTime,
        'hasBill': hasBill
      };
}
