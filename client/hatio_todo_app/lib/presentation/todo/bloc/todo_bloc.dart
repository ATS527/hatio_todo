import 'package:bloc/bloc.dart';
import 'package:hatio_todo_app/data/repository/todo_repository.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // ignore: unused_field
  final TodoRepository _todoRepository = TodoRepository();

  TodoBloc() : super(TodoInitial()) {
    on<TodoEvent>((event, emit) {});
  }
}
