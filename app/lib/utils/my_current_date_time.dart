import 'package:intl/intl.dart';

String currentYear = DateTime.now().year.toString();
String currentDay = DateTime.now().day.toString();
String currentMonth = DateFormat('MMMM').format(DateTime.now());

String currentDate = '$currentDay $currentMonth, $currentYear';
