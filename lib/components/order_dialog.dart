import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaners/constants.dart';
import 'package:cleaners/models/dto/planning_dto.dart';
import 'package:flutter/material.dart';

class OrderDialog extends StatelessWidget {
  final PlanningDto planningDto;
  final Function onCreatePlanning;

  OrderDialog({@required this.planningDto, @required this.onCreatePlanning});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kPadding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    var photo = planningDto.professional.picture == null
        ? AssetImage('assets/images/profile.png')
        : CachedNetworkImageProvider(planningDto.professional.picture);

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: kAvatarRadius + kPadding,
            bottom: kPadding,
            left: kPadding,
            right: kPadding,
          ),
          margin: EdgeInsets.only(top: kAvatarRadius),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(kPadding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                'Passer la commande',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(height: 16.0),
              Text(
                planningDto.service.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.0, color: Theme.of(context).primaryColor),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      child: Text(
                        'Annuler',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16.0),
                      ),
                    ),
                    FlatButton(
                      onPressed: onCreatePlanning,
                      child: Text(
                        'Confirmer',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.5),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: CircleAvatar(
            radius: 50.0,
            backgroundImage: photo,
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
