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

  Planning.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        professionalId = json['professional_id'],
        customerId = json['customer_id'],
        serviceId = json['service_id'],
        date = json['date'],
        startHour = json['start_hour'],
        endHour = json['end_hour'],
        statusId = json['status_id'];

  DateTime startTime() {
    return DateTime.parse("$date${startHour.substring(startHour.indexOf('T'))}");
  }

  DateTime endTime() {
    return DateTime.parse("$date${endHour.substring(endHour.indexOf('T'))}");
  }
}
