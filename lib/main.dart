import 'package:cleaners/screens/service_screen.dart';
import 'package:cleaners/screens/services_list_screen.dart';
import 'package:cleaners/screens/tab_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(HouseCleaners());

class HouseCleaners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF222428),
        scaffoldBackgroundColor: Color(0xFFFED330),
        accentColor: Color(0xFFFED330),
      ),
      initialRoute: TabScreen.id,
      home: TabScreen(),
      onGenerateRoute: (settings) {
        MaterialPageRoute pageRoute;
        if (settings.name == ServicesListScreen.id) {
          final String servicesType = settings.arguments;
          pageRoute = MaterialPageRoute(
            builder: (context) {
              return ServicesListScreen(servicesType);
            },
          );
        } else if(settings.name == ServiceScreen.id) {
          final int serviceId = settings.arguments;
          pageRoute = MaterialPageRoute(
            builder: (context) {
              return ServiceScreen(serviceId: serviceId);
            },
          );
        }
        return pageRoute;
      },
    );
  }
}
