import 'package:cleaners/models/dto/logged_in_user.dart';
import 'package:cleaners/models/person.dart';
import 'package:cleaners/notifiers/auth_notifier.dart';
import 'package:flushbar/flushbar.dart';
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
      color: Colors.black12,
      margin: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                style: TextStyle(fontSize: 30.0, color: Colors.white),
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
                  icon: Icon(
                    Icons.person_outline,
                    size: 30.0,
                  ),
                ),
              ),
              TextFormField(
                style: TextStyle(fontSize: 30.0, color: Colors.white),
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
                  hintText: 'Mot de passe',
                  icon: Icon(
                    Icons.lock_outline,
                    size: 30.0,
                  ),
                ),
              ),
              FlatButton.icon(
                textColor: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    Provider.of<AuthNotifier>(context, listen: false)
                        .login(email, password)
                        .whenComplete(() {
                      LoggedInUser loggedInUser =
                          Provider.of<AuthNotifier>(context, listen: false).loggedInUser;
                      if (loggedInUser != null) {
                        loggedInPerson = loggedInUser.user.person;
                        Flushbar(
                          message: 'Bienvenu ${loggedInPerson.firstName}...',
                          icon: Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                          duration: Duration(seconds: 4),
                          leftBarIndicatorColor: Colors.green,
                        ).show(context);
                      } else {
                        Flushbar(
                          message: 'Oops, Connexion échouée...',
                          icon: Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          ),
                          duration: Duration(seconds: 4),
                          leftBarIndicatorColor: Colors.red,
                        ).show(context);
                      }
                    });
                  }
                },
                icon: Icon(
                  Icons.exit_to_app,
                  size: 30.0,
                ),
                label: Text(
                  'Se connecter',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20.0),
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
