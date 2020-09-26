import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaners/models/reservation.dart';
import 'package:cleaners/utils/date_utils.dart';
import 'package:flutter/material.dart';

class ReservationComponent extends StatelessWidget {
  final Reservation reservation;

  ReservationComponent({@required this.reservation});

  @override
  Widget build(BuildContext context) {
    var photo = reservation.professional.picture == null
        ? AssetImage('assets/images/profile.png')
        : CachedNetworkImageProvider(reservation.professional.picture);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: reservation.startTime.isBefore(DateTime.now())
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
                  '${reservation.professional.firstName} ${reservation.professional.lastName}',
                  style: TextStyle(color: Colors.white),
                ),
                Badge(
                  badgeContent: Text(
                    '${reservation.expertise.hourlyRate}€/h',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
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
                Text('${reservation.expertise.service.title}',
                    style: TextStyle(color: Colors.white))
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
                    '${DateUtils.dateToString(reservation.startTime, "dd-MM-yyyy")}, '
                    '${DateUtils.dateToString(reservation.startTime, "HH:mm")} - '
                    '${DateUtils.dateToString(reservation.endTime, "HH:mm")}',
                    style: TextStyle(color: Colors.white))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
