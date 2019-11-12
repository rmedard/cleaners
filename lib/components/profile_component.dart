import 'package:cleaners/Services/auth_service.dart';
import 'package:cleaners/models/person.dart';
import 'package:cleaners/notifiers/user_login_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileComponent extends StatelessWidget {
  final Person person;

  const ProfileComponent({@required this.person});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Card(
          margin: EdgeInsets.only(top: 55.0, left: 20.0, right: 20.0),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    '${person.lastName}, ${person.firstName}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        '${person.streetName} ${person.plotNumber}, ${person.postCode} ${person.cityName}',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: RaisedButton.icon(
                    icon: Icon(Icons.exit_to_app),
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      await new AuthService().logout();
                      Provider.of<UserLoginNotifier>(context).getLoggedInUser();
                    },
                    label: Text('Se deconnecter'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3.0),
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage(person.picture),
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
