import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatio_todo_app/data/data_provider/project_data_provider.dart';
import 'package:hatio_todo_app/data/data_provider/todo_data_provider.dart';
import 'package:hatio_todo_app/data/data_provider/user_data_provider.dart';
import 'package:hatio_todo_app/globals.dart';
import 'package:hatio_todo_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:hatio_todo_app/presentation/todo/bloc/todo_bloc.dart';

void main() {
  group("all todo tests", () {
    late TodoDataProvider todoDataProvider;
    late UserDataProvider userDataProvider;
    late ProjectDataProvider projectDataProvider;

    setUp(() {
      todoDataProvider = TodoDataProvider();
      userDataProvider = UserDataProvider();
      projectDataProvider = ProjectDataProvider();
    });
    test("Initial State", () {
      expect(TodoBloc().state, TodoInitial());
    });

    blocTest(
      "login success with registered email",
      build: () => AuthBloc(),
      wait: const Duration(seconds: 1),
      act: (bloc) => bloc.add(
        LoginButtonPressed(
          email: "newUser@gmail.com",
          password: "strongPassword#123",
        ),
      ),
      expect: () => [AuthLoading(), AuthSuccess()],
      tearDown: () async {
        final userDataProvider = UserDataProvider();

        final user = await userDataProvider.loginUserData(
            "newUser@gmail.com", "strongPassword#123");

        projectId = user["user"]["project_ids"][0];

        jwtKey = user["token"];

        userId = user["user"]["id"];
      },
    );

    blocTest(
      "Getting all Todos of current project on initial load",
      build: () => TodoBloc(),
      act: (bloc) => bloc.add(
        InitialTodoEvent(projectId: projectId),
      ),
      wait: const Duration(seconds: 1),
      expect: () => [TodoLoading(), isA<TodoLoadSuccess>()],
    );

    blocTest(
      "Adding a new Todo",
      build: () => TodoBloc(),
      act: (bloc) {
        bloc.add(
          AddTodoButtonPressed(
            projectId: projectId,
            name: "New Todo",
          ),
        );
      },
      wait: const Duration(seconds: 1),
      expect: () => [TodoLoading(), isA<TodoAdded>()],
      tearDown: () async {
        final todo = await todoDataProvider.getProjectTodosData(projectId);
        todoId = todo[0]["id"];
      },
    );

    blocTest(
      "Updating a Todo",
      build: () => TodoBloc(),
      act: (bloc) {
        bloc.add(
          UpdateTodo(
            projectId: projectId,
            todoId: todoId,
            name: "Updated Todo",
          ),
        );
      },
      wait: const Duration(seconds: 1),
      expect: () => [TodoLoading(), isA<TodoUpdated>()],
    );

    blocTest(
      "Updating a Todo Status",
      build: () => TodoBloc(),
      act: (bloc) {
        bloc.add(
          UpdateTodoStatus(
            projectId: projectId,
            todoId: todoId,
            status: true,
          ),
        );
      },
      wait: const Duration(seconds: 1),
      expect: () => [TodoLoading(), isA<TodoUpdated>()],
    );

    blocTest("Deleting a Todo",
        build: () => TodoBloc(),
        act: (bloc) {
          bloc.add(
            DeleteTodo(
              projectId: projectId,
              todoId: todoId,
            ),
          );
        },
        wait: const Duration(seconds: 1),
        expect: () => [TodoLoading(), TodoDeleted(todos: const [])],
        tearDown: () async {
          await projectDataProvider.deleteProjectData(projectId);
          await userDataProvider.deleteUser(userId);
        });
  });
}
