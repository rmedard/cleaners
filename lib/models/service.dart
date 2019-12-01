import 'package:cleaners/models/professional.dart';

class Service {
  int id;
  String name;
  String description;
  int categoryId;
  List<Professional> professionals = [];

  Service({this.id, this.name, this.description, this.categoryId});

  Service.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        categoryId = json['category_id'],
        professionals = json['professionals'] == null
            ? []
            : (json['professionals'] as List<dynamic>)
                .map((p) => Professional.fromJson(p as Map<String, dynamic>))
                .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category_id': categoryId,
        'professionals': professionals
      };
}
