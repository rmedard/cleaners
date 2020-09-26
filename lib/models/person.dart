import 'package:cleaners/models/address.dart';

class Person {
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  int addressId;
  Address address;
  String picture;
  int userId;

  Person(this.email, this.firstName, this.lastName, this.phoneNumber,
      this.address, this.picture, this.userId);

  Person.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        phoneNumber = json['phoneNumber'],
        addressId = json['addressId'],
        address = json['address'] == null ? null : Address.fromJson(json['address']),
        picture = json['picture'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'address': address.toJson(),
        'picture': picture
      };
}
