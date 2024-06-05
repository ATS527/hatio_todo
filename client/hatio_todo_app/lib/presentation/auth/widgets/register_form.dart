import 'package:flutter/material.dart';
import 'package:hatio_todo_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:lottie/lottie.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _registerKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        padding: const EdgeInsets.symmetric(horizontal: 156.0),
        child: Column(
          children: [
            SizedBox(
                height: 260,
                child: Lottie.asset(
                    'assets/animations/register_todo_animation.json')),
            TextFormField(
              validator: nameValidation,
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              validator: emailValidation,
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              validator: passwordValidation,
              controller: _passwordController,
              obscureText: false,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Colors.green[200],
                ),
              ),
              onPressed: () {
                if (_registerKey.currentState!.validate()) {
                  authBloc.add(
                    RegisterButtonPressed(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    ),
                  );
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 56, vertical: 12),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const Text(
                    'Register',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Colors.orange[200],
                ),
              ),
              onPressed: () {
                authBloc.add(GoToLogin());
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 56, vertical: 12),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
