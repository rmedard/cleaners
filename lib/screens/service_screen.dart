import 'package:cleaners/components/professional_component.dart';
import 'package:cleaners/components/service_component.dart';
import 'package:cleaners/models/professional.dart';
import 'package:cleaners/models/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceScreen extends StatefulWidget {
  static const String id = 'service_screen';
  final int serviceId;

  ServiceScreen({this.serviceId});

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  RangeValues _sliderValues = RangeValues(8, 18);
  DateTime selectedDateTime = DateTime.now().add(Duration(hours: 1));

  @override
  Widget build(BuildContext context) {
    Service dummyService = getDummyService();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Service ${widget.serviceId}',
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ServiceComponent(
              service: dummyService, clickable: false,
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Text(
                      'Date',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25.0),
                    ),
                    title: Text(
                      DateFormat('d-MMM-y').format(selectedDateTime),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    trailing: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor,),
                    onTap: () async {
                      DateTime newDateTime = await showDatePicker(
                          context: context,
                          initialDate: selectedDateTime,
                          firstDate: DateTime(2019),
                          lastDate: DateTime(2030),
                          selectableDayPredicate: (DateTime selectable) {
                            return selectable.isAfter(DateTime.now());
                          });
                      setState(() {
                        selectedDateTime = newDateTime == null ? selectedDateTime : newDateTime;
                      });
                    },
                  ),
                  RangeSlider(
                    values: _sliderValues,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _sliderValues = values;
                      });
                    },
                    min: 8.0,
                    max: 18.0,
                    divisions: 10,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: dummyService.professionals.length,
                  itemBuilder: (context, index) {
                    return ProfessionalComponent(
                      professional: dummyService.professionals[index],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 2.0,
                    color: Theme.of(context).primaryColor,
                    thickness: 2.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Service getDummyService() {
    Service service = Service(
        id: 1,
        name: 'Service test',
        description: 'Paralysis, rumour, and courage. '
            'The uniqueness of your sorrows will listen safely '
            'when you invent that bliss is the yogi.');
    service.professionals = [
      Professional(
          id: 1,
          firstName: 'Alfred',
          lastName: 'UZABAKILIHO',
          picture: 'assets/images/profile.png',
          price: 4.0),
      Professional(
          id: 2,
          firstName: 'Mariam',
          lastName: 'Uwizeyimana',
          picture: 'assets/images/profile.png',
          price: 19.0),
      Professional(
          id: 3,
          firstName: 'Jessica',
          lastName: 'Alba',
          picture: 'assets/images/profile.png',
          price: 5.0),
      Professional(
          id: 4,
          firstName: 'Halle',
          lastName: 'Barry',
          picture: 'assets/images/profile.png',
          price: 15.0),
    ];
    return service;
  }
}
