import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaners/constants.dart';
import 'package:cleaners/models/dto/reservation_for_create.dart';
import 'package:cleaners/models/expertise.dart';
import 'package:cleaners/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderDialog extends StatelessWidget {
  final ReservationForCreate reservation;
  final Expertise expertise;
  final Function onCreateReservation;

  OrderDialog(
      {@required this.reservation,
      @required this.expertise,
      @required this.onCreateReservation});

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
    var photo = expertise.professional.picture == null
        ? AssetImage('assets/images/profile.png')
        : CachedNetworkImageProvider(expertise.professional.picture);

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
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(height: 16.0),
              Text(
                expertise.service.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                    color: Theme.of(context).primaryColor),
              ),
              Text(
                'executé par',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.0, color: Theme.of(context).primaryColor),
              ),
              Text(
                '${expertise.professional.firstName.trim()}, '
                '${expertise.professional.lastName.trim()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 24.0),
              Text(
                  'Le ${DateUtils.dateToString(reservation.startTime, 'dd-MM-yyyy')}, '
                  'de ${DateUtils.dateToString(reservation.startTime, 'HH:mm')} '
                  'à ${DateUtils.dateToString(reservation.startTime.add(new Duration(hours: reservation.duration)), 'HH:mm')}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700)),
              Chip(
                backgroundColor: Theme.of(context).primaryColor,
                avatar: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.euro_symbol,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                label: Text(
                  '${expertise.hourlyRate * reservation.duration}',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ButtonBar(
                  children: <Widget>[
                    OutlineButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Annuler',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16.0),
                      ),
                      borderSide: BorderSide(
                          style: BorderStyle.solid, color: Colors.black),
                    ),
                    OutlineButton(
                      onPressed: onCreateReservation,
                      child: Text(
                        'Confirmer',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16.0),
                      ),
                      borderSide: BorderSide(
                          style: BorderStyle.solid, color: Colors.black),
                    ),
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
