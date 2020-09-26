import 'package:cleaners/models/expertise.dart';
import 'package:cleaners/models/professional.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

class Reservation {
  int id;
  int customerId;
  DateTime startTime;
  DateTime endTime;
  double totalCost;
  Status status;
  Expertise expertise;
  Professional professional;

  Reservation(
      {this.id,
      this.customerId,
      this.startTime,
      this.endTime,
      this.totalCost,
      this.status,
      this.expertise,
      this.professional});

  Reservation.toCreate(
      {@required this.customerId,
      @required this.startTime,
      @required this.endTime,
      this.status = Status.Confirmed,
      @required this.expertise,
      this.totalCost});

  Reservation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        customerId = json['customerId'],
        startTime = DateTime.parse(json['startTime']),
        endTime = DateTime.parse(json['endTime']),
        status = Status.values.firstWhere((s) => EnumToString.convertToString(s) == json['status']),
        expertise = Expertise.fromJson(json['expertise']),
        totalCost = json['totalCost'],
        professional = json['professional'] == null ? null : Professional.fromJson(json['professional']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'customerId': customerId,
        'startTime': startTime,
        'endTime': endTime,
        'status': status,
        'expertise': expertise.toJson()
      };

  Map<String, dynamic> toNewJson() => {
        'customerId': customerId,
        'startTime': startTime,
        'endTime': endTime,
        'status': status,
        'expertise': expertise.toJson()
      };
}

enum Status { Confirmed, Rejected }
