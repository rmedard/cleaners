import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaners/components/order_dialog.dart';
import 'package:cleaners/models/dto/planning_dto.dart';
import 'package:cleaners/models/planning.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProfessionalComponent extends StatelessWidget {
  final PlanningDto planningDto;
  final SlidableController slidableController = SlidableController();

  ProfessionalComponent({@required this.planningDto});

  void createPlanning(Planning planning) {
    print(jsonEncode(planning));
  }

  @override
  Widget build(BuildContext context) {
    var photo = planningDto.professional.picture == null
        ? AssetImage('assets/images/profile.png')
        : CachedNetworkImageProvider(planningDto.professional.picture);



    return Slidable(
      controller: slidableController,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        IconSlideAction(
          closeOnTap: true,
          foregroundColor: Theme.of(context).accentColor,
          caption: 'Commander',
          color: Theme.of(context).primaryColor,
          icon: Icons.add,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => OrderDialog(
                planningDto: planningDto,
                onCreatePlanning: createPlanning,
              ),
            );
          },
        ),
      ],
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text(
            '${planningDto.professional.lastName} ${planningDto.professional.firstName}',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          leading: CircleAvatar(
            backgroundImage: photo,
            maxRadius: 25.0,
          ),
          trailing: Chip(
            label: Text('${planningDto.professional.price} €/h'),
            avatar: Icon(Icons.euro_symbol),
            backgroundColor: Colors.transparent,
          ),
          subtitle: Text(
            'Subtitle here',
            style: TextStyle(color: Colors.black38),
          ),
        ),
      ),
      closeOnScroll: true,
    );
  }
}
