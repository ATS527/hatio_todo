import 'dart:convert';

import 'package:hatio_todo_app/utils/globals.dart';
import 'package:http/http.dart' as http;

class TodoDataProvider {
  static const _baseUrl = AppConstants.baseUrl;

  Future<Map<String, dynamic>> createTodoData(
      {required String projectId, required String title}) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/createTodo/$projectId'),
        body: {
          "description": title,
          "project_id": projectId,
        },
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

  Future<Map<String, dynamic>> getProjectTodosData(String projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/getProjectTodos/$projectId'),
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

  Future<Map<String, dynamic>> updateTodoData(
      String todoId, String title) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/updateTodo/$todoId"),
        body: {
          "description": title,
        },
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

  Future<Map<String, dynamic>> deleteTodoData(
      String projectId, String todoId) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseUrl/deleteTodo"),
        body: {
          "project_id": projectId,
          "todo_id": todoId,
        },
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
}
