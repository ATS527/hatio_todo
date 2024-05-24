import 'package:hatio_todo_app/utils/globals.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  static const _baseUrl = AppConstants.baseUrl;

  Future<String> registerUser(
      String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        body: {
          "name": name,
          "email": email,
          "password": password,
        },
      );

      return response.body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        body: {
          "email": email,
          "password": password,
        },
      );

      return response.body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future logoutUser() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/logout'),
      );

      return response.body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
