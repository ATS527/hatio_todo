import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hatio_todo_app/data/data_provider/project_data_provider.dart';
import 'package:hatio_todo_app/data/data_provider/user_data_provider.dart';
import 'package:hatio_todo_app/globals.dart';
import 'package:hatio_todo_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:hatio_todo_app/presentation/project/bloc/project_bloc.dart';

void main() {
  group("project bloc tests", () {
    late ProjectDataProvider projectDataProvider;

    setUp(() {
      projectDataProvider = ProjectDataProvider();
    });

    test("Initial State", () {
      expect(ProjectBloc().state, ProjectInitial());
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

        jwtKey = user["token"];
      },
    );

    blocTest(
      "Initially fetching all the currently logged in user's projects",
      build: () => ProjectBloc(),
      act: (bloc) => bloc.add(InitialProjectEvent()),
      wait: const Duration(seconds: 1),
      expect: () => [ProjectLoading(), isA<ProjectLoadSuccess>()],
    );

    blocTest(
      "Adding a new project",
      build: () => ProjectBloc(),
      act: (bloc) {
        bloc.add(AddProjectButtonPressed(name: "New Project"));
      },
      wait: const Duration(seconds: 1),
      expect: () => [ProjectLoading(), isA<ProjectAdded>()],
      tearDown: () async {
        final project = await projectDataProvider.getUserProjectsData();
        projectId = project[0]["id"];
      },
    );

    blocTest(
      "Updating the project title",
      build: () => ProjectBloc(),
      act: (bloc) {
        bloc.add(UpdateProject(projectId: projectId, name: "Updated Project"));
      },
      wait: const Duration(seconds: 1),
      expect: () => [ProjectLoading(), isA<ProjectUpdated>()],
    );
  });

  // All Other Tests could not be conducted since the API uses cookie to fetch the jwt access token to authenticate the user (for better security).
}
