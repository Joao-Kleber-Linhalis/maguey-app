import 'package:intl/intl.dart';

extension FormatDateTime on DateTime {
  String toDDMMYYYHHMINAM() {
    return DateFormat("dd/MM/yyyy-hh:mm a").format(this);
  }
}
