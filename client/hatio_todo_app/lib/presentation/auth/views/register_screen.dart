import 'package:flutter/material.dart';
import 'package:hatio_todo_app/presentation/auth/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Screen"),
      ),
      body: const CustomForm(),
    );
  }
}
