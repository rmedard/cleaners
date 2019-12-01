import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaners/models/dto/planning_dto.dart';
import 'package:cleaners/models/planning.dart';
import 'package:cleaners/utils/date_utils.dart';
import 'package:flutter/material.dart';

class PlanningComponent extends StatelessWidget {
  final PlanningDto planningDto;

  PlanningComponent({@required this.planningDto});

  @override
  Widget build(BuildContext context) {
    Planning planning = planningDto.planning;
    var photo = planningDto.professional.picture == null
        ? AssetImage('assets/images/profile.png')
        : CachedNetworkImageProvider(planningDto.professional.picture);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: planning.startTime().isBefore(DateTime.now())
            ? Border.all(color: Colors.red, width: 3.0)
            : Border.all(color: Colors.green, width: 3.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 5.0),
        title: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    '${planningDto.professional.firstName} ${planningDto.professional.lastName}'),
                Badge(
                  badgeContent: Text(
                    '${planningDto.professional.price}€/h',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                  shape: BadgeShape.square,
                  borderRadius: 10.0,
                  toAnimate: false,
                  badgeColor: Theme.of(context).accentColor,
                ),
              ],
            ),
            Divider(color: Theme.of(context).accentColor, thickness: 1.0),
          ],
        ),
        leading: CircleAvatar(
          backgroundImage: photo,
          maxRadius: 25.0,
        ),
        subtitle: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Service',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                Text('${planningDto.service.name}')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Date',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                Text(
                    '${DateUtils.dateToString(planning.startTime(), "dd-MM-yyyy")}, '
                    '${DateUtils.dateToString(planning.startTime(), "HH:mm")} - '
                    '${DateUtils.dateToString(planning.endTime(), "HH:mm")}')
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//ClipOval(
//child: planningDto.professional.picture == null
//? Image.asset('assets/images/profile.png',
//width: 55.0, height: 55.0)
//: Image.network(planningDto.professional.picture,
//width: 55.0, height: 55.0, fit: BoxFit.fitHeight),
//)

//Container(
//width: 59.0,
//decoration: BoxDecoration(
//shape: BoxShape.circle,
//image: DecorationImage(
//fit: BoxFit.cover,
//image: planningDto.professional.picture == null
//? AssetImage('assets/images/profile.png')
//: NetworkImage(planningDto.professional.picture)),
//),
//)
