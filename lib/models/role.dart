import 'package:enum_to_string/enum_to_string.dart';

class Role {
  int id;
  RoleName roleName;

  Role.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        roleName =
            RoleName.values.firstWhere((r) => EnumToString.convertToString(r) == json['roleName']);

  Map<String, dynamic> toJson() => {'id': id, 'roleName': roleName};
}

enum RoleName { Admin, Customer, Professional }
