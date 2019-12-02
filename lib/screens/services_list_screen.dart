import 'package:cleaners/components/service_component.dart';
import 'package:cleaners/models/arguments/service_argument.dart';
import 'package:flutter/material.dart';

class ServicesListScreen extends StatelessWidget {
  static const String id = 'services_list_screen';
  final ServiceArgument _serviceArgument;

  ServicesListScreen(this._serviceArgument);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nos services d\'${_serviceArgument.serviceType}',
          style: TextStyle(
            color: Color(0xFFFED330),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 15.0),
            itemCount: _serviceArgument.services.length,
            itemBuilder: (context, index) {
              return ServiceComponent(
                service: _serviceArgument.services[index],
                clickable: true,
              );
            },
          ),
        ),
      ),
    );
  }
}
