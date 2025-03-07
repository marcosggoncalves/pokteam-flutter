import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService  {
  final String baseUrl = dotenv.env['POKEAPI_URL'] ?? "";

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    
    throw Exception('Pokemon não localizado.');
  }
}
