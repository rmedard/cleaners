import 'package:cleaners/components/login_form_component.dart';
import 'package:cleaners/components/profile_component.dart';
import 'package:cleaners/models/person.dart';
import 'package:cleaners/notifiers/user_login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static const String id = 'profile_screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<UserLoginNotifier>(
      builder: (context, notifier, child) {
        Person loggedInUser = notifier.loggedInUser;
        return Container(
            child: loggedInUser != null
                ? ProfileComponent(person: loggedInUser)
                : LoginFormComponent());
      },
    );
  }
}
