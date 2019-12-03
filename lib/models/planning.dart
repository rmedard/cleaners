import 'package:flutter/material.dart';

class Planning {
  int id;
  int professionalId;
  int customerId;
  int serviceId;
  String date;
  String startHour;
  String endHour;
  int statusId;

  Planning(
      {this.id,
      this.professionalId,
      this.customerId,
      this.serviceId,
      this.date,
      this.startHour,
      this.endHour,
      this.statusId});

  Planning.toCreate(
      {@required this.professionalId,
      @required this.customerId,
      @required this.serviceId,
      @required this.date,
      @required this.startHour,
      @required this.endHour,
      this.statusId = 1});

  Planning.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        professionalId = json['professional_id'],
        customerId = json['customer_id'],
        serviceId = json['service_id'],
        date = json['date'],
        startHour = json['start_hour'],
        endHour = json['end_hour'],
        statusId = json['status_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'professional_id': professionalId,
        'customer_id': customerId,
        'service_id': serviceId,
        'date': date,
        'start_hour': startHour,
        'end_hour': endHour,
        'status_id': statusId
      };

  Map<String, dynamic> toNewJson() => {
        'professional_id': professionalId,
        'customer_id': customerId,
        'service_id': serviceId,
        'date': date,
        'start_hour': startHour,
        'end_hour': endHour,
        'status_id': statusId
      };

  DateTime startTime() {
    if(date.contains('T')) {
      return DateTime.parse(
          "${date.substring(0, date.indexOf('T'))}${startHour.substring(startHour.indexOf('T'))}");
    } else {
      return DateTime.parse(
          "$date${startHour.substring(startHour.indexOf('T'))}");
    }
  }

  DateTime endTime() {
    if(date.contains('T')) {
      return DateTime.parse(
          "${date.substring(0, date.indexOf('T'))}${endHour.substring(endHour.indexOf('T'))}");
    } else {
      return DateTime.parse(
          "$date${endHour.substring(endHour.indexOf('T'))}");
    }
  }
}
