import 'package:intl/intl.dart';

String formatVNDPrice(num price) {
  final intAmount = price.toInt();

  final formatter = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '₫',
    decimalDigits: 0,
  );

  return formatter.format(intAmount);
}
