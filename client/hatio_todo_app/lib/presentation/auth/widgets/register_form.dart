import 'package:flutter/material.dart';
import 'package:hatio_todo_app/presentation/auth/views/login_screen.dart';
import 'package:hatio_todo_app/presentation/project/views/project_screen.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _registerKey = GlobalKey<FormState>();

  String? nameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters';
    } else if (value.length > 30) {
      return 'Name must be at most 30 characters';
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (value.length > 30) {
      return 'Password must be at most 30 characters';
    } else if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) == false) {
      return 'Password must contain special characters';
    } else if (value.contains(RegExp(r'[0-9]')) == false) {
      return 'Password must contain numbers';
    } else if (value.contains(RegExp(r'[A-Z]')) == false) {
      return 'Password must contain uppercase';
    } else if (value.contains(RegExp(r'[a-z]')) == false) {
      return 'Password must contain lowercase';
    }
    return null;
  }

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value.contains('@') == false) {
      return 'Email must contain @';
    } else if (value.contains('.') == false) {
      return 'Email must contain .';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: nameValidation,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            TextFormField(
              validator: emailValidation,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            TextFormField(
              validator: passwordValidation,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            ElevatedButton(
              onPressed: () {
                if (_registerKey.currentState!.validate()) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ProjectScreen(),
                    ),
                  );
                }
              },
              child: const Text('Register'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
