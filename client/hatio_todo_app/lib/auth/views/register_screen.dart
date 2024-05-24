import 'package:flutter/material.dart';
import 'package:hatio_todo_app/auth/widgets/custom_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomForm(),
    );
  }
}
