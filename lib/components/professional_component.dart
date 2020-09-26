import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaners/Services/auth_service.dart';
import 'package:cleaners/Services/reservations_service.dart';
import 'package:cleaners/components/order_dialog.dart';
import 'package:cleaners/models/dto/reservation_for_create.dart';
import 'package:cleaners/models/expertise.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProfessionalComponent extends StatelessWidget {
  final ReservationForCreate reservationForCreate;
  final List<Expertise> expertises;
  final SlidableController slidableController = SlidableController();
  final ReservationsService _reservationsService = ReservationsService();
  final AuthService _authService = AuthService();

  ProfessionalComponent(
      {@required this.reservationForCreate, @required this.expertises});

  @override
  Widget build(BuildContext context) {
    var expertise = expertises.firstWhere((element) =>
        element.professionalId ==
            reservationForCreate.expertiseForServiceCreate.professionalId &&
        element.serviceId == reservationForCreate.expertiseForServiceCreate.serviceId);
    var photo = expertise.professional.picture == null
        ? AssetImage('assets/images/profile.png')
        : CachedNetworkImageProvider(expertise.professional.picture);

    void createReservation() {
      _reservationsService
          .createReservation(reservationForCreate: reservationForCreate)
          .then((reservation) {
        String message = reservation != null
            ? 'Commande passée acess succès'
            : 'Oops, commande échouée...';
        IconData iconData =
            reservation != null ? Icons.check_circle_outline : Icons.error_outline;
        Color color = reservation != null ? Colors.green : Colors.red;
        Flushbar(
          message: message,
          icon: Icon(
            iconData,
            color: color,
          ),
          duration: Duration(seconds: 4),
          leftBarIndicatorColor: color,
        ).show(context);
      });
      Navigator.of(context).pop();
    }

    void showOrderConfirmation() {
      _authService.getLoggedInUser().then((user) {
        if (user != null) {
          showDialog(
            context: context,
            builder: (BuildContext context) => OrderDialog(
              reservation: reservationForCreate,
              expertise: expertise,
              onCreateReservation: createReservation,
            ),
          );
        } else {
          Flushbar(
            message: 'Vous devez vous connecter pour commander',
            icon: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
            duration: Duration(seconds: 4),
            leftBarIndicatorColor: Colors.red,
          ).show(context);
        }
      });
    }

    return Slidable(
      key: Key('${expertise.professional.id}'),
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
          onTap: showOrderConfirmation,
        ),
      ],
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text(
            '${expertise.professional.lastName} ${expertise.professional.firstName}',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          leading: CircleAvatar(
            backgroundImage: photo,
            maxRadius: 25.0,
          ),
          trailing: Chip(
            label: Text(
              '${expertise.hourlyRate} €/h',
              style: TextStyle(
                  color: Theme.of(context).accentColor, fontSize: 18.0),
            ),
            avatar: Icon(
              Icons.euro_symbol,
              color: Theme.of(context).accentColor,
            ),
            shape: StadiumBorder(side: BorderSide()),
            backgroundColor: Theme.of(context).primaryColor,
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
