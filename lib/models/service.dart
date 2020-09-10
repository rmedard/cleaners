import 'package:cleaners/models/professional.dart';
import 'package:flutter/foundation.dart';

class Service {
  int id;
  String name;
  String description;
  Category category;
  List<Professional> professionals = [];

  Service({this.id, this.name, this.description, this.category});

  Service.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['title'],
        description = json['description'] == null ? "" : json['description'],
        category = json['category'] == 'Exterieur'
            ? Category.EXTERIEUR
            : Category.INTERIEUR,
        professionals = json['professionals'] == null
            ? []
            : (json['professionals'] as List<dynamic>)
                .map((p) => Professional.fromJson(p as Map<String, dynamic>))
                .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'description': description,
        'category': category.toString(),
        'professionals': professionals
      };
}

enum Category { INTERIEUR, EXTERIEUR }
