import 'dart:convert';

import 'package:cleaners/models/customer.dart';
import 'package:http/http.dart';

import '../constants.dart';

class CustomersService {
  final String apiUrl = kApiUrl;

  Future<Customer> getCustomerByUserId({int customerId}) async {
    var url = '$apiUrl/customers/userId/$customerId';
    var customer;
    Response response = await get(url);
    if (response.statusCode == 200) {
      customer = Customer.fromJson(jsonDecode(response.body));
    }
    return customer;
  }
}
