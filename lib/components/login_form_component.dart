import 'package:cleaners/Services/auth_service.dart';
import 'package:cleaners/models/person.dart';
import 'package:cleaners/notifiers/user_login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginFormComponent extends StatefulWidget {
  @override
  _LoginFormComponentState createState() => _LoginFormComponentState();
}

class _LoginFormComponentState extends State<LoginFormComponent> {
  final _formKey = GlobalKey<FormState>();
  AuthService _authService = new AuthService();

  String email;
  String password;
  Person loggedInPerson;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  return value.isEmpty
                      ? 'Veuillez introduire votre email'
                      : null;
                },
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    hintText: 'Adresse Email',
                    icon: Icon(Icons.person_outline)),
              ),
              TextFormField(
                validator: (value) {
                  return value.isEmpty
                      ? 'Veuillez introduire votre mot de passe'
                      : null;
                },
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Mot de passe', icon: Icon(Icons.lock_outline)),
              ),
              FlatButton.icon(
                textColor: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Processing Data...'),
                      ),
                    );
                    loggedInPerson = await _authService.login(email, password);
                    Provider.of<UserLoginNotifier>(context).getLoggedInUser();
                  }
                },
                icon: Icon(
                  Icons.exit_to_app,
                ),
                label: Text(
                  'Se connecter',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
