import 'package:bloc/bloc.dart';
import 'package:hatio_todo_app/data/model/todo.dart';
import 'package:hatio_todo_app/data/repository/todo_repository.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // ignore: unused_field
  final TodoRepository _todoRepository = TodoRepository();

  TodoBloc() : super(TodoInitial()) {
    on<InitialTodoEvent>((event, emit) async {
      emit(TodoLoading());
      try {
        List<Todo> todos =
            await _todoRepository.getProjectTodos(event.projectId);

        emit(TodoLoadSuccess(todos: todos));
      } catch (e) {
        emit(TodoLoadFailure(error: e.toString()));
      }
    });

    on<AddTodoButtonPressed>((event, emit) async {
      emit(TodoLoading());
      try {
        await _todoRepository.createTodo(event.projectId, event.name);

        List<Todo> todos =
            await _todoRepository.getProjectTodos(event.projectId);

        emit(TodoAdded(todos: todos));
      } catch (e) {
        emit(TodoLoadFailure(error: e.toString()));
      }
    });

    on<UpdateTodo>((event, emit) async {
      emit(TodoLoading());
      try {
        await _todoRepository.updateTodo(event.todoId, event.name);

        List<Todo> todos =
            await _todoRepository.getProjectTodos(event.projectId);

        emit(TodoUpdated(todos: todos));
      } catch (e) {
        emit(TodoLoadFailure(error: e.toString()));
      }
    });

    on<UpdateTodoStatus>((event, emit) async {
      emit(TodoLoading());
      try {
        await _todoRepository.updateTodoStatus(event.todoId, event.status);

        List<Todo> todos =
            await _todoRepository.getProjectTodos(event.projectId);

        emit(TodoUpdated(todos: todos));
      } catch (e) {
        emit(TodoLoadFailure(error: e.toString()));
      }
    });

    on<DeleteTodo>((event, emit) async {
      emit(TodoLoading());
      try {
        await _todoRepository.deleteTodo(event.projectId, event.todoId);

        List<Todo> todos =
            await _todoRepository.getProjectTodos(event.projectId);

        emit(TodoDeleted(todos: todos));
      } catch (e) {
        emit(TodoLoadFailure(error: e.toString()));
      }
    });
  }
}

final todoBloc = TodoBloc();
