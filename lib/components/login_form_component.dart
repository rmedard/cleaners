import 'package:flutter/material.dart';

class LoginFormComponent extends StatefulWidget {
  @override
  _LoginFormComponentState createState() => _LoginFormComponentState();
}

class _LoginFormComponentState extends State<LoginFormComponent> {
  final _formKey = GlobalKey<FormState>();

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
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Mot de passe', icon: Icon(Icons.lock_outline)),
                ),
                FlatButton.icon(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data...')));
                    }
                  },
                  icon: Icon(
                    Icons.input,
                  ),
                  label: Text(
                    'Se connecter',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  color: Theme.of(context).accentColor,
                )
              ],
            )),
      ),
    );
  }
}
