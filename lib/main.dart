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
  static final RangeThumbSelector _customRangeThumbSelector = (
    TextDirection textDirection,
    RangeValues values,
    double tapValue,
    Size thumbSize,
    Size trackSize,
    double dx,
  ) {
    final double start = (tapValue - values.start).abs();
    final double end = (tapValue - values.end).abs();
    return start < end ? Thumb.start : Thumb.end;
  };

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => AuthNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF222428),
          scaffoldBackgroundColor: Color(0xFFFED330),
          accentColor: Color(0xFFFED330),
          textSelectionHandleColor: Color(0xFFFED330),
          toggleableActiveColor: Color(0xFFFED330),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFF222428)),
          sliderTheme: SliderThemeData(
            thumbSelector: _customRangeThumbSelector,
            activeTrackColor: Color(0xFF222428),
            activeTickMarkColor: Color(0xFFFED330),
            thumbColor: Color(0xFF222428),
            overlayColor: Color(0x1D222428),
            valueIndicatorColor: Color(0xFF222428),
            inactiveTrackColor: Color(0xFFFED330),
          ),
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
