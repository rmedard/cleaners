import 'package:cleaners/components/service_component.dart';
import 'package:cleaners/models/service.dart';
import 'package:flutter/material.dart';

class ServicesListScreen extends StatelessWidget {
  static const String id = 'services_list_screen';

  final String servicesType;
  final List<Service> services = [
    Service(
        id: 1,
        name: 'Service 1',
        description: 'Fluctuss resistere in quadrata!Yes, there is zion, '
            'it travels with hypnosis. Ecce, talis era! Fluctuss resistere '
            'in quadrata!Yes, there is zion, it travels with hypnosis. '
            'Ecce, talis era!'),
    Service(
        id: 2,
        name: 'Service 2',
        description: 'Fluctuss resistere in quadrata!'),
    Service(
        id: 3,
        name: 'Service 3',
        description: 'Fluctuss resistere in quadrata!'),
  ];

  ServicesListScreen(this.servicesType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nos services d\'$servicesType',
          style: TextStyle(
            color: Color(0xFFFED330),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            return ServiceComponent(
              service: services[index], clickable: true,
            );
          },
        ),
      ),
    );
  }
}
