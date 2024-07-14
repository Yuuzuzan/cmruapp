import 'dart:convert';

import 'package:cmruapp/config/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PageServices {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<List<dynamic>> fetchPages() async {
    final response = await http.get(
      Uri.parse('$API_URL/api/pages'),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
    return jsonDecode(response.body);
  }
}
