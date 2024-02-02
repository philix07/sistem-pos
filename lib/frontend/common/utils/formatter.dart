import 'package:intl/intl.dart';

class AppFormatter {
  static String number(int num) {
    NumberFormat formatter = NumberFormat("#,##0", "id_ID");

    // Format the integer
    return formatter.format(num);
  }
}
