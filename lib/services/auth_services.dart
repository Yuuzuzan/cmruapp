import 'dart:convert';

import 'package:cmruapp/config/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<bool> checkLoglin() async {
    final prefs = await _prefs;
    final token = prefs.getString('token');
    if (token != null) {
      return true;
    }
    return false;
  }

  static Future<bool> login(String email, String password) async {
    final resonse = await http.post(
      Uri.parse('$API_URL/api/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },  
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (resonse.statusCode == 200) {
      final prefs = await _prefs;
      await prefs.setString('token', jsonDecode(resonse.body)['token']);
      return true;
    }
    return false;
  }
}
