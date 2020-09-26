import 'dart:convert';

import 'package:cleaners/models/dto/reservation_for_create.dart';
import 'package:cleaners/models/dto/reservation_search_criteria.dart';
import 'package:cleaners/models/reservation.dart';
import 'package:http/http.dart';

import '../constants.dart';
import 'auth_service.dart';

class ReservationsService {
  final String apiUrl = kApiUrl;
  final AuthService _authService = AuthService();

  Future<List<Reservation>> getAll() async {
    var loggedInUser = await _authService.getLoggedInUser();
    var url = '$apiUrl/reservations';
    Response response = await get(url,
        headers: {"Authorization": "Bearer " + loggedInUser.token});
    List<Reservation> reservations = [];
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      data.forEach((service) {
        reservations.add(Reservation.fromJson(service as Map<String, dynamic>));
      });
    }
    return reservations;
  }

  Future<List<Reservation>> getReservations(
      ReservationSearchCriteria searchCriteria) async {
    var loggedInUser = await _authService.getLoggedInUser();

    var url = '$apiUrl/reservations/search';
    List<Reservation> reservations = [];
    Response response = await post(url,
        body: json.encode(searchCriteria.toJson()),
        headers: {"Authorization": "Bearer " + loggedInUser.token});
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      data.forEach((reservation) {
        reservations.add(Reservation.fromJson(reservation as Map<String, dynamic>));
      });
    }
    return reservations;
  }

  Future<Reservation> createReservation(
      {ReservationForCreate reservationForCreate}) async {
    var loggedInUser = await _authService.getLoggedInUser();
    var url = '$apiUrl/reservations';
    var reservation;

    Response response = await post(url,
        body: json.encode(reservationForCreate.toJson()),
        headers: {
          "Authorization": "Bearer " + loggedInUser.token,
          "Content-Type": "application/json"
        });
    if (response.statusCode == 201) {
      reservation = Reservation.fromJson(jsonDecode(response.body));
    }
    return reservation;
  }
}
