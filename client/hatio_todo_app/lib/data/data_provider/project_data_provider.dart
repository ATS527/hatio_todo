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
          "description": title,
        },
      );

      return jsonDecode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<Map<String, dynamic>> getUserProjectsData() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/getUserProjects'),
      );

      return jsonDecode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<Map<String, dynamic>> getProjectDetailsData(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/getProjectDetails/$id'),
      );

      return jsonDecode(response.body);
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

      return jsonDecode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}