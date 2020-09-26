import 'package:cleaners/models/dto/logged_in_user.dart';
import 'package:cleaners/models/person.dart';
import 'package:cleaners/notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileComponent extends StatelessWidget {
  final LoggedInUser loggedInUser;
  final double profilePicRadius = 50.0;

  const ProfileComponent({@required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    Person person = loggedInUser.user.person;
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Card(
          margin: EdgeInsets.only(
              top: profilePicRadius + 5, left: 20.0, right: 20.0, bottom: 20.0),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: profilePicRadius),
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
                        '${person.address.streetName} ${person.address.plotNumber}, ${person.address.postalCode} ${person.address.city}',
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
                      await Provider.of<AuthNotifier>(context).logout();
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
            border: Border.all(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(profilePicRadius),
          ),
          child: CircleAvatar(
            radius: profilePicRadius,
            backgroundImage: person.picture == null || person.picture.isEmpty
                ? AssetImage('assets/images/profile.png')
                : NetworkImage(person.picture),
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
