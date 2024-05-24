import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatio_todo_app/bloc_observer.dart';
import 'package:hatio_todo_app/data/repository/project_repository.dart';
import 'package:hatio_todo_app/data/repository/user_repository.dart';
import 'package:hatio_todo_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:hatio_todo_app/presentation/auth/views/login_screen.dart';
import 'package:hatio_todo_app/presentation/project/bloc/project_bloc.dart';
import 'package:hatio_todo_app/presentation/project/views/project_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hatio-Todo-App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepositoryProvider.value(
        value: _userRepository,
        child: BlocProvider(
          create: (_) => AuthBloc(_userRepository),
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
          return RepositoryProvider(
            create: (context) => ProjectRepository(),
            child: BlocProvider(
              create: (context) => ProjectBloc(),
              child: const ProjectScreen(),
            ),
          );
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
