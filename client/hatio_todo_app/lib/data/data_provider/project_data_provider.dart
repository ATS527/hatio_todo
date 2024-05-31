import 'dart:convert';

import 'package:hatio_todo_app/utils/globals.dart';
import 'package:http/http.dart' as http;

class ProjectDataProvider {
  static const _baseUrl = AppConstants.baseUrl;

  Future<Map<String, dynamic>> createProjectData(String title) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/createProject'),
        body: {
          "title": title,
        },
      );

      final result = jsonDecode(response.body);

      if (result["success"] == false) {
        throw Exception(result["message"]);
      }

      return result["project"];
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<List<dynamic>> getUserProjectsData() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/getUserProjects'),
      );

      final result = jsonDecode(response.body);

      if (result["success"] == false) {
        throw Exception(result["message"]);
      }

      return result["project"];
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<Map<String, dynamic>> getProjectDetailsData(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/getProjectDetails/$id'),
      );

      final result = jsonDecode(response.body);

      if (result["success"] == false) {
        throw Exception(result["message"]);
      }

      return result["project"];
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<Map<String, dynamic>> updateProjectTitleData(
      {required String id, required String title}) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/updateProjectTitle/$id'),
        body: {
          "title": title,
        },
      );

      final result = jsonDecode(response.body);

      if (result["success"] == false) {
        throw Exception(result["message"]);
      }

      return result["project"];
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
