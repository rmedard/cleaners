import 'package:cleaners/Services/auth_service.dart';
import 'package:cleaners/Services/customers_service.dart';
import 'package:cleaners/Services/professionals_service.dart';
import 'package:cleaners/Services/reservations_service.dart';
import 'package:cleaners/components/reservation_component.dart';
import 'package:cleaners/models/dto/logged_in_user.dart';
import 'package:cleaners/models/dto/reservation_search_criteria.dart';
import 'package:cleaners/models/reservation.dart';
import 'package:cleaners/models/role.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

class Reservations extends StatefulWidget {
  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  final AuthService _authService = AuthService();
  final ReservationsService _reservationsService = ReservationsService();
  ReservationSearchCriteria searchCriteria;

  LoggedInUser loggedInUser;

  @override
  void initState() {
    super.initState();
    _authService.getLoggedInUser().then((user) {
      setState(() {
        loggedInUser = user;
        if (loggedInUser != null) {
          var userRole = user.user.roles[0];
          if (EnumToString.convertToString(RoleName.Professional) == userRole) {
            searchCriteria = ReservationSearchCriteria.create(
                professionalId: loggedInUser.user.professionalId);
          } else if (EnumToString.convertToString(RoleName.Customer) ==
              userRole) {
            searchCriteria = ReservationSearchCriteria.create(
                professionalId: loggedInUser.user.customerId);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loggedInUser == null) {
      return FlatButton(
        // used by assistive technologies
        child: Text('Please login first!!',
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 30)),
        onPressed: () {
          // Navigator.pushNamed(context, Profile.id);
        },
      );
    }

    return FutureBuilder<List<Reservation>>(
      future: EnumToString.convertToString(RoleName.Admin) ==
              loggedInUser.user.roles[0]
          ? _reservationsService.getAll()
          : _reservationsService.getReservations(searchCriteria),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return Text(snapshot.hasError
                ? snapshot.error.toString()
                : 'Pas de reservations trouvées');
          } else {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print(snapshot);
                return ReservationComponent(reservation: snapshot.data[index]);
              },
              separatorBuilder: (context, index) => Divider(height: 3.0),
              itemCount: snapshot.data.length,
              padding: EdgeInsets.all(8.0),
            );
          }
        } else if (snapshot.hasError) {
          return Text(snapshot.hasError
              ? snapshot.hasError.toString()
              : 'Pas de reservations trouvées');
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }
}
