import 'package:cleaners/Services/plannings_service.dart';
import 'package:cleaners/components/planning_component.dart';
import 'package:cleaners/models/dto/planning_dto.dart';
import 'package:flutter/material.dart';

class Plannings extends StatefulWidget {
  @override
  _PlanningsState createState() => _PlanningsState();
}

class _PlanningsState extends State<Plannings> {
  final PlanningsService _planningsService = PlanningsService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PlanningDto>>(
        future: _planningsService.getPlannings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return PlanningComponent(planningDto: snapshot.data[index]);
              },
              separatorBuilder: (context, index) => Divider(height: 3.0),
              itemCount: snapshot.data.length,
              padding: EdgeInsets.all(8.0),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }
        });
  }
}
