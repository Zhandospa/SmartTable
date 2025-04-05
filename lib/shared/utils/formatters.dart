import 'package:intl/intl.dart';

final _priceFormat = NumberFormat("#,##0", "ru_RU");

String formatPrice(num price) {
  return _priceFormat.format(price);
}
