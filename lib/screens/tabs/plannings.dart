import 'package:cleaners/components/planning_component.dart';
import 'package:flutter/material.dart';

class Plannings extends StatelessWidget {
  final List<PlanningComponent> plannings = [
    PlanningComponent(),
    PlanningComponent()
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return PlanningComponent();
        },
        separatorBuilder: (context, index) => Divider(height: 3.0),
        itemCount: plannings.length,
        padding: EdgeInsets.all(8.0),
      ),
    );
  }
}
