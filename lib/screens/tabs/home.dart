import 'package:cleaners/Services/services_service.dart';
import 'package:cleaners/models/arguments/service_argument.dart';
import 'package:cleaners/models/service.dart';
import 'package:cleaners/screens/services_list_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ServicesService _servicesService = ServicesService();
  List<Service> interiorServices = [];
  List<Service> exteriorServices = [];

  @override
  void initState() {
    super.initState();
    _servicesService.getServices().then((services) {
      setState(() {
        interiorServices = services.where((x) => x.categoryId == 1).toList();
        exteriorServices = services.where((x) => x.categoryId == 2).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ServicesListScreen.id,
                arguments: ServiceArgument(serviceType: 'interieur', services: interiorServices));
          },
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('assets/images/interieur.jpg'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Interieur',
                          style: TextStyle(
                              fontSize: 50.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        color: Color(0xAAFED330),
                        child: Center(
                          child: Text(
                            '${interiorServices.length} Services',
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ServicesListScreen.id,
                arguments: ServiceArgument(serviceType: 'exterieur', services: exteriorServices));
          },
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset('assets/images/exterieur.jpg'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Exterieur',
                          style: TextStyle(
                              fontSize: 50.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        color: Color(0xAAFED330),
                        child: Center(
                          child: Text(
                            '${exteriorServices.length} Services',
                            style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
