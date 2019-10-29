import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class PlanningComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(color: Colors.red, width: 2.0),
      ),
      child: ListTile(
        title: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Uzabakiliho Alfred'),
                Badge(
                  badgeContent: Text(
                    '35€/h',
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
            Divider(color: Theme.of(context).accentColor, thickness: 1.0)
          ],
        ),
        leading: FittedBox(
          fit: BoxFit.fill,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
            radius: 30.0,
          ),
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
                Text('Jardinage')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Date',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                Text('10-12-2019, 10:00 - 11:00')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
