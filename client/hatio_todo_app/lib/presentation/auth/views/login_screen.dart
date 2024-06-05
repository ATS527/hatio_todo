import 'package:flutter/material.dart';
import 'package:hatio_todo_app/presentation/auth/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hatio Todos | Login Screen'),
      ),
      body: const LoginForm(),
    );
  }
}
