class Person {
  int id;
  String email;
  int typeId;
  String firstName;
  String lastName;
  String phoneNumber;
  String plotNumber;
  String streetName;
  String cityName;
  String postCode;
  String picture;

  Person(
      this.id,
      this.email,
      this.typeId,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.plotNumber,
      this.streetName,
      this.cityName,
      this.postCode,
      this.picture);

  Person.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        typeId = json['type_id'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        phoneNumber = json['phone_number'],
        plotNumber = json['plot_number'],
        streetName = json['street_name'],
        cityName = json['city_name'],
        postCode = json['post_code'],
        picture = json['picture'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'type_id': typeId,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'plot_number': plotNumber,
        'street_name': streetName,
        'city_name': cityName,
        'post_code': postCode,
        'picture': picture
      };
}
