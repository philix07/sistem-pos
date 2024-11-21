import 'package:intl/intl.dart';

class AppFormatter {
  static String number(int num) {
    NumberFormat formatter = NumberFormat("#,##0", "id_ID");

    // Format the integer
    return formatter.format(num);
  }

  static String dateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMMM yy, HH:mm:ss');
    return formatter.format(dateTime);
  }

  static String dmy(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(dateTime);
  }

  static String dmyShort(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MMMM/yyyy');
    return formatter.format(dateTime);
  }

  static String time(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm:ss');
    return formatter.format(dateTime);
  }

  static String monthYear(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MMMM yyyy');
    return formatter.format(dateTime);
  }
}
