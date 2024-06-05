import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatio_todo_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:hatio_todo_app/presentation/auth/views/login_screen.dart';
import 'package:hatio_todo_app/presentation/auth/views/register_screen.dart';
import 'package:hatio_todo_app/presentation/project/views/project_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hatio-Todo-App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const InitialiserScreen(),
    );
  }
}

class InitialiserScreen extends StatelessWidget {
  const InitialiserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        bloc: authBloc,
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, state) {
          if (state is AuthInitial) {
            authBloc.add(InitialAuthEvent());
            return const LoginScreen();
          } else if (state is AuthSuccess) {
            return const ProjectScreen();
          } else if (state is AuthLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AuthRegister) {
            return const RegisterScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
