import 'package:cleaners/models/person.dart';
import 'package:cleaners/notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginFormComponent extends StatefulWidget {
  @override
  _LoginFormComponentState createState() => _LoginFormComponentState();
}

class _LoginFormComponentState extends State<LoginFormComponent> {
  final _formKey = GlobalKey<FormState>();

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
                    Provider.of<AuthNotifier>(context)
                        .login(email, password)
                        .whenComplete(() {
                      loggedInPerson = Provider.of<AuthNotifier>(context)
                          .loggedInUser
                          .person;
                    });
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
