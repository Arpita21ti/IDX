import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a provider for API base URLs (you can add more global variables this way)
final apiBaseUrlProvider = Provider<String>((ref) {
  // Fetched this from .env or use a default value
  final String? apiBaseUrl = dotenv.env['API_BASE_URL'];

  if (apiBaseUrl == null || apiBaseUrl.isEmpty) {
    return 'No proper base url set!!!  ';
  }

  return apiBaseUrl;
});
