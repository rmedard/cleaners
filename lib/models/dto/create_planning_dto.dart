import 'package:cleaners/models/planning.dart';

class CreatePlanningDto {
  List<Planning> plannings;

  CreatePlanningDto({this.plannings});

  Map<String, dynamic> toJson() =>
      {'planning': plannings.map((planning) => planning.toNewJson()).toList()};
}
