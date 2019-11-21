import 'package:cleaners/components/login_form_component.dart';
import 'package:cleaners/components/profile_component.dart';
import 'package:cleaners/notifiers/auth_notifier.dart';
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
    return Consumer<AuthNotifier>(
      builder: (context, notifier, child) {
        return Container(
            child: notifier.loggedInUser != null
                ? ProfileComponent(loggedInUser: notifier.loggedInUser)
                : LoginFormComponent());
      },
    );
  }
}
