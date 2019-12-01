import 'package:intl/intl.dart';

class DateUtils {
  static String dateToString(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }

  static DateTime soonestSelectableDate() {
    return _computeSoonest(DateTime.now().add(Duration(hours: 1)));
  }

  static bool isBookable(DateTime dateTime) {
    DateTime current = DateTime.now();
    bool bookable = false;
    if (dateTime.isAfter(current) &&
        dateTime.weekday != 6 &&
        dateTime.weekday != 7) {
      bookable = true;
      if (dateTime.year == current.year &&
          dateTime.month == current.month &&
          dateTime.day == current.day) {
        bookable = dateTime.hour < 17;
      }
    }
    return bookable;
  }

  static DateTime _computeSoonest(DateTime soonestDate) {
    if (!isBookable(soonestDate)) {
      return _computeSoonest(soonestDate.add(Duration(days: 1)));
    }
    return soonestDate;
  }
}
