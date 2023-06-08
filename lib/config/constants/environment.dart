import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String googleMapApiKey =
      dotenv.env['GOOGLE_MAPS_API_KEY'] ?? 'No hay api key';
}
