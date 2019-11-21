import 'package:cleaners/models/arguments/service_argument.dart';
import 'package:cleaners/models/service.dart';
import 'package:cleaners/notifiers/auth_notifier.dart';
import 'package:cleaners/screens/service_screen.dart';
import 'package:cleaners/screens/services_list_screen.dart';
import 'package:cleaners/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(HouseCleaners());

class HouseCleaners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => AuthNotifier(),
      child: MaterialApp(
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
            final ServiceArgument serviceArgument = settings.arguments;
            pageRoute = MaterialPageRoute(
              builder: (context) {
                return ServicesListScreen(serviceArgument);
              },
            );
          } else if (settings.name == ServiceScreen.id) {
            final Service service = settings.arguments;
            pageRoute = MaterialPageRoute(
              builder: (context) {
                return ServiceScreen(service: service);
              },
            );
          }
          return pageRoute;
        },
      ),
    );
  }
}
