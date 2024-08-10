import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _loginUrl = 'https://api-agendaai.vercel.app/login';

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final String token = responseBody['token'];
      final String username = responseBody['username'];
      final String papel = responseBody['papel'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('username', username);
      await prefs.setString('papel', papel);
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['error']);
    }
  }

  Future<bool> isAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null;
  }

  Future<String?> getPapel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('papel');
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('username');
    await prefs.remove('papel');
  }
}
