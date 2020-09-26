import 'package:cleaners/models/role.dart';
import 'package:cleaners/models/user.dart';

class RoleUser {
  int roleId;
  int userId;
  Role role;
  User user;

  RoleUser.name(this.roleId, this.userId);


}