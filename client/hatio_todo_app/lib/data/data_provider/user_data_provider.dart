import 'dart:convert';

import 'package:hatio_todo_app/utils/globals.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  static const _baseUrl = AppConstants.baseUrl;

  Future<Map<String, dynamic>> registerUserData(
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

      final result = jsonDecode(response.body);

      if (result["success"] == false) {
        throw Exception(result["message"]);
      }

      return result;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<Map<String, dynamic>> loginUserData(
      String email, String password) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/login'), body: {
        "email": email,
        "password": password,
      });

      final result = jsonDecode(response.body);

      if (result["success"] == false) {
        throw Exception(result["message"]);
      }

      return result;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<bool> logoutUserData() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/logout'),
      );

      final result = jsonDecode(response.body);

      if (result["success"] == false) {
        throw Exception(result["message"]);
      }

      return result["success"];
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/me'),
      );

      return jsonDecode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
