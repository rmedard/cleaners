import 'package:cleaners/Services/services_service.dart';
import 'package:cleaners/models/service.dart';
import 'package:cleaners/screens/service_screen.dart';
import 'package:flutter/material.dart';

class ServiceComponent extends StatelessWidget {
  final Service service;
  final bool clickable;
  final ServicesService _servicesService = ServicesService();

  ServiceComponent({@required this.service, @required this.clickable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (clickable) {
          _servicesService.getService(service).then((s) {
            Navigator.pushNamed(context, ServiceScreen.id, arguments: s);
          });
        }
      },
      child: Card(
        margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 5,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                  ),
                  color: Theme.of(context).primaryColor),
              child: ListTile(
                leading: Icon(Icons.done_all),
                title: Text(
                  service.name,
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 25.0),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  service.description,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
