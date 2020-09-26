class Address {
  int id;
  String streetName;
  String plotNumber;
  String city;
  int postalCode;

  Address.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        streetName = json['streetName'],
        plotNumber = json['plotNumber'],
        city = json['city'],
        postalCode = json['postalCode'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'streetName': streetName,
        'plotNumber': plotNumber,
        'city': city,
        'postalCode': postalCode
      };

  Map<String, dynamic> toNewJson() => {
        'streetName': streetName,
        'plotNumber': plotNumber,
        'city': city,
        'postalCode': postalCode
      };
}
