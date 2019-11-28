import 'package:cleaners/models/professional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProfessionalComponent extends StatelessWidget {
  final Professional professional;

  ProfessionalComponent({this.professional});

  @override
  Widget build(BuildContext context) {
    var photo = professional.picture == null
        ? AssetImage('assets/images/profile.png')
        : NetworkImage(professional.picture);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        IconSlideAction(
          foregroundColor: Theme.of(context).accentColor,
          caption: 'Commander',
          color: Theme.of(context).primaryColor,
          icon: Icons.add,
          onTap: () {},
        ),
      ],
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text(
            '${professional.lastName} ${professional.firstName}',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          leading: CircleAvatar(
            backgroundImage: photo,
            maxRadius: 25.0,
          ),
          trailing: Chip(
            label: Text('${professional.price} €/h'),
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
