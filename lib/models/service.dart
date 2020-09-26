import 'package:cleaners/models/professional.dart';
import 'package:enum_to_string/enum_to_string.dart';

class Service {
  int id;
  String title;
  String description;
  Category category;

  Service({this.id, this.title, this.description, this.category});

  Service.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'] == null ? "" : json['description'],
        category =
            Category.values.firstWhere((e) => EnumToString.convertToString(e) == json['category']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category.toString()
      };
}

enum Category { Interieur, Exterieur }
