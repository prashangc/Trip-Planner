import 'package:flutter_dotenv/flutter_dotenv.dart';

String getDotEnvValue(value) {
  return dotenv.env[value].toString();
}
