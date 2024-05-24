import 'package:hatio_todo_app/utils/globals.dart';
import 'package:http/http.dart' as http;

class TodoDataProvider {
  static const _baseUrl = AppConstants.baseUrl;

  Future<String> createTodo(
      {required String projectId, required String title}) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/createTodo/$projectId'),
        body: {
          "description": title,
          "project_id": projectId,
        },
      );

      return response.body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future getProjectTodos(String projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/getProjectTodos/$projectId'),
      );

      return response.body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future updateTodo(String todoId, String title) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/updateTodo/$todoId"),
        body: {
          "description": title,
        },
      );

      return response.body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future deleteTodo(String todoId) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseUrl/deleteTodo/$todoId"),
      );

      return response.body;
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
