part of 'todo_bloc.dart';

@immutable
sealed class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoLoadSuccess extends TodoState {
  final List<Todo> todos;

  TodoLoadSuccess({
    required this.todos,
  });
}

final class TodoLoadFailure extends TodoState {
  final String error;

  TodoLoadFailure({
    required this.error,
  });
}

final class TodoAdded extends TodoState {
  final List<Todo> todos;

  TodoAdded({
    required this.todos,
  });
}

final class TodoUpdated extends TodoState {
  final List<Todo> todos;

  TodoUpdated({
    required this.todos,
  });
}

final class TodoDeleted extends TodoState {
  final List<Todo> todos;

  TodoDeleted({
    required this.todos,
  });
}
