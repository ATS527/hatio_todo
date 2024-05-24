import 'package:hatio_todo_app/utils/globals.dart';
import 'package:http/http.dart' as http;

class ProjectDataProvider {
  static const _baseUrl = AppConstants.baseUrl;

  Future createProject(String title) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/createProject'),
        body: {
          "description": title,
        },
      );

      return response.body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future getUserProjects() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/getUserProjects'),
      );

      return response.body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future getProjectDetails(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/getProjectDetails/$id'),
      );

      return response.body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future updateProjectTitle({required String id, required String title}) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/updateProjectTitle/$id'),
        body: {
          "title": title,
        },
      );

      return response.body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
