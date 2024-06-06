import 'package:flutter_test/flutter_test.dart';
import 'package:hatio_todo_app/presentation/todo/bloc/todo_bloc.dart';

void main() {
  group("all todo tests", () {
    test("Initial State", () {
      expect(TodoBloc().state, TodoInitial());
    });
  });
}
