import 'package:intl/intl.dart';

String formatNumberCount(int number) =>
    NumberFormat.compact(locale: "en_US").format(number);
