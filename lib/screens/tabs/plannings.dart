import 'package:cleaners/Services/plannings_service.dart';
import 'package:cleaners/components/planning_component.dart';
import 'package:cleaners/models/planning.dart';
import 'package:flutter/material.dart';

class Plannings extends StatefulWidget {
  @override
  _PlanningsState createState() => _PlanningsState();
}

class _PlanningsState extends State<Plannings> {
  final PlanningsService _planningsService = PlanningsService();
  List<Planning> plannings = [];

  @override
  void initState() {
    super.initState();
    _planningsService.getPlannings().then((plans) {
      setState(() {
        plannings = plans;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return PlanningComponent(planning: plannings[index]);
      },
      separatorBuilder: (context, index) => Divider(height: 3.0),
      itemCount: plannings.length,
      padding: EdgeInsets.all(8.0),
    );
  }
}
