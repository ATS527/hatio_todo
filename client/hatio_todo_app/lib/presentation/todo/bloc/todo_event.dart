part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class InitialTodoEvent extends TodoEvent {
  final String projectId;

  InitialTodoEvent({
    required this.projectId,
  });
}

final class AddTodoButtonPressed extends TodoEvent {
  final String name;
  final String projectId;

  AddTodoButtonPressed({
    required this.name,
    required this.projectId,
  });
}

final class UpdateTodo extends TodoEvent {
  final String todoId;
  final String name;
  final String projectId;

  UpdateTodo({
    required this.todoId,
    required this.name,
    required this.projectId,
  });
}

final class UpdateTodoStatus extends TodoEvent {
  final String projectId;
  final String todoId;
  final bool status;

  UpdateTodoStatus({
    required this.projectId,
    required this.todoId,
    required this.status,
  });
}

final class DeleteTodo extends TodoEvent {
  final String todoId;
  final String projectId;

  DeleteTodo({required this.todoId, required this.projectId});
}
