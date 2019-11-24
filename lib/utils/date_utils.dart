import 'package:intl/intl.dart';

class DateUtils {
  static String dateToString(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }
}
