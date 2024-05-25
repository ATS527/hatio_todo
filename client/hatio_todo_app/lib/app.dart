import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatio_todo_app/data/repository/project_repository.dart';
import 'package:hatio_todo_app/data/repository/todo_repository.dart';
import 'package:hatio_todo_app/data/repository/user_repository.dart';
import 'package:hatio_todo_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:hatio_todo_app/presentation/auth/views/login_screen.dart';
import 'package:hatio_todo_app/presentation/project/bloc/project_bloc.dart';
import 'package:hatio_todo_app/presentation/project/views/project_screen.dart';
import 'package:hatio_todo_app/presentation/todo/bloc/todo_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final UserRepository _userRepository = UserRepository();
  final ProjectRepository _projectRepository = ProjectRepository();
  final TodoRepository _todoRepository = TodoRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hatio-Todo-App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: _userRepository),
          RepositoryProvider.value(value: _projectRepository),
          RepositoryProvider.value(value: _todoRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                RepositoryProvider.of<UserRepository>(context),
              ),
            ),
            BlocProvider(
              create: (context) => ProjectBloc(
                RepositoryProvider.of<ProjectRepository>(context),
              ),
            ),
            BlocProvider(
              create: (context) => TodoBloc(
                RepositoryProvider.of<TodoRepository>(context),
              ),
            ),
          ],
          child: const InitialiserScreen(),
        ),
      ),
    );
  }
}

class InitialiserScreen extends StatelessWidget {
  const InitialiserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AuthBloc>(context),
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        if (state is AuthInitial) {
          return const LoginScreen();
        } else if (state is AuthSuccess) {
          return const ProjectScreen();
        } else if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AuthFailure) {
          return Scaffold(
            body: Center(
              child: Text('Something went wrong! ${state.message}'),
            ),
          );
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
