import 'package:intl/intl.dart';

class MainUtilities {
  String formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(amount);
  }
}
