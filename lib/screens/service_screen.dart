import 'package:cleaners/Services/auth_service.dart';
import 'package:cleaners/components/professional_component.dart';
import 'package:cleaners/components/service_component.dart';
import 'package:cleaners/constants.dart';
import 'package:cleaners/models/dto/logged_in_user.dart';
import 'package:cleaners/models/dto/planning_dto.dart';
import 'package:cleaners/models/planning.dart';
import 'package:cleaners/models/service.dart';
import 'package:cleaners/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceScreen extends StatefulWidget {
  static const String id = 'service_screen';
  final Service service;

  ServiceScreen({this.service});

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  AuthService _authService = AuthService();
  RangeValues _sliderValues = RangeValues(8, 18);
  DateTime selectedDateTime = DateUtils.soonestSelectableDate();
  LoggedInUser loggedInUser;

  @override
  void initState() {
    super.initState();
    _authService.getLoggedInUser().then((user) {
      setState(() {
        loggedInUser = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int year = selectedDateTime.year;
    int month = selectedDateTime.month;
    int day = selectedDateTime.day;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Passer la commande',
          style: TextStyle(
            color: Theme.of(context).accentColor,
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
          child: Column(
            children: <Widget>[
              ServiceComponent(
                service: widget.service,
                clickable: false,
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
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
                        DateFormat('d-MMMM-y').format(selectedDateTime),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      trailing: Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () async {
                        DateTime newDateTime = await showDatePicker(
                            context: context,
                            initialDate: selectedDateTime,
                            firstDate: DateTime(DateTime.now().year),
                            lastDate: DateTime(DateTime.now().year + 2),
                            initialDatePickerMode: DatePickerMode.day,
                            selectableDayPredicate: (DateTime selectable) {
                              return DateUtils.isBookable(selectable);
                            });
                        setState(() {
                          selectedDateTime = newDateTime == null
                              ? selectedDateTime
                              : newDateTime;
                        });
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Text('${_sliderValues.start.round()}h', style: TextStyle(fontSize: 20.0),),
                        Expanded(
                          child: RangeSlider(
                            values: _sliderValues,
                            labels: RangeLabels('${_sliderValues.start.round()}h',
                                '${_sliderValues.end.round()}h'),
                            min: 8.0,
                            max: 18.0,
                            divisions: 10,
                            onChanged: (RangeValues values) {
                              setState(() {
                                if (values.end - values.start >= 1) {
                                  _sliderValues = values;
                                } else {
                                  if (_sliderValues.start == values.start) {
                                    _sliderValues = RangeValues(
                                        _sliderValues.start, _sliderValues.start + 1);
                                  } else {
                                    _sliderValues = RangeValues(
                                        _sliderValues.end - 1, _sliderValues.end);
                                  }
                                }
                              });
                            },
                          ),
                        ),
                        Text('${_sliderValues.end.round()}h', style: TextStyle(fontSize: 20.0),),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: widget.service.professionals.length,
                  itemBuilder: (context, index) {
                    return ProfessionalComponent(
                      planningDto: PlanningDto(
                          professional: widget.service.professionals[index],
                          planning: Planning.toCreate(
                              professionalId:
                                  widget.service.professionals[index].id,
                              customerId: loggedInUser == null
                                  ? 0
                                  : loggedInUser.person.id,
                              serviceId: widget.service.id,
                              date:
                                  '${DateUtils.dateToString(selectedDateTime, 'yyyy-MM-dd')}T00:00:00.000',
                              startHour: DateUtils.dateToString(
                                  DateTime(year, month, day,
                                      _sliderValues.start.truncate(), 0, 0),
                                  kMainDateTimeFormat),
                              endHour: DateUtils.dateToString(
                                  DateTime(year, month, day,
                                      _sliderValues.end.truncate(), 0, 0),
                                  kMainDateTimeFormat)),
                          service: widget.service),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    height: 2.0,
                    color: Theme.of(context).primaryColor,
                    thickness: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
