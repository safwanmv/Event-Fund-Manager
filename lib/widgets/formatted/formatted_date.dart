import 'package:intl/intl.dart';

class FormattedDate {
  static String date(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
}
