class Professional {
  int id;
  String firstName;
  String lastName;
  String picture;
  double price = 0;

  Professional(
      {this.id, this.firstName, this.lastName, this.picture, this.price});

  Professional.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        picture = json['picture'],
        price = json['price'];
}
