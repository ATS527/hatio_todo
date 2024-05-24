import 'package:hatio_todo_app/data/data_provider/todo_data_provider.dart';
import 'package:hatio_todo_app/data/model/todo.dart';

class TodoRepository {
  final TodoDataProvider _todoDataProvider = TodoDataProvider();

  Future<Todo> createTodo(String projectId, String title) async {
    var response = await _todoDataProvider.createTodoData(
        projectId: projectId, title: title);

    return Todo.fromJson(response);
  }

  Future<List<Todo>> getProjectTodos(String projectId) async {
    var response = await _todoDataProvider.getProjectTodosData(projectId);

    return Todo.fromJsonToList(response);
  }

  Future<Todo> updateTodo(String todoId, String title) async {
    var response = await _todoDataProvider.updateTodoData(todoId, title);

    return Todo.fromJson(response);
  }

  Future<bool> deleteTodoData(String projectId, String todoId) async {
    var response = await _todoDataProvider.deleteTodoData(projectId, todoId);

    if (response["success"] == "true") {
      return true;
    } else {
      return false;
    }
  }
}
