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
        typeId = json['typeId'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        phoneNumber = json['phoneNumber'],
        plotNumber = json['plotNumber'],
        streetName = json['streetName'],
        cityName = json['cityName'],
        postCode = json['postCode'],
        picture = json['picture'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'typeId': typeId,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'plotNumber': plotNumber,
        'streetName': streetName,
        'cityName': cityName,
        'postCode': postCode,
        'picture': picture
      };
}
