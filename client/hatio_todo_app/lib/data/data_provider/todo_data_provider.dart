import 'dart:convert';

import 'package:hatio_todo_app/globals.dart';
import 'package:hatio_todo_app/utils/globals.dart';
import 'package:http/http.dart' as http;

class TodoDataProvider {
  static const _baseUrl = AppConstants.baseUrl;

  Future<dynamic> createTodoData(
      {required String projectId, required String title}) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/createTodo'),
        body: {
          "description": title,
          "project_id": projectId,
        },
        headers: {
          "authorization": jwtKey,
        },
      );

      final result = jsonDecode(response.body);

      if (result["success"] == false) {
        throw Exception(result["message"]);
      }

      return result["todo"];
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<dynamic> getProjectTodosData(String projectId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/getProjectTodos/$projectId'),
        headers: {
          "authorization": jwtKey,
        },
      );

      final result = jsonDecode(response.body);

      if (result["success"] == false) {
        throw Exception(result["message"]);
      }

      return result["todos"];
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<dynamic> updateTodoStatus(String todoId, bool status) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/updateTodo/$todoId"),
        body: {
          "status": status.toString(),
        },
        headers: {
          "authorization": jwtKey,
        },
      );

      final result = jsonDecode(response.body);

      if (result["success"] == false) {
        throw Exception(result["message"]);
      }

      return result["todo"];
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<dynamic> updateTodoData(
    String todoId,
    String title,
  ) async {
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl/updateTodo/$todoId"),
        body: {
          "description": title,
        },
        headers: {
          "authorization": jwtKey,
        },
      );

      final result = jsonDecode(response.body);

      if (result["success"] == false) {
        throw Exception(result["message"]);
      }

      return result["todo"];
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  Future<dynamic> deleteTodoData(String projectId, String todoId) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseUrl/deleteTodo"),
        body: {
          "project_id": projectId,
          "todo_id": todoId,
        },
        headers: {
          "authorization": jwtKey,
        },
      );

      final result = jsonDecode(response.body);

      if (result["success"] == false) {
        throw Exception(result["message"]);
      }

      return result["message"];
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
