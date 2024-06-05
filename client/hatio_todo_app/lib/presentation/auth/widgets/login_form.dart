import 'package:flutter/material.dart';
import 'package:hatio_todo_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:lottie/lottie.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      key: _loginKey,
      child: Column(
        children: <Widget>[
          Lottie.asset('assets/animations/todo_login_animation.json'),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 156.0),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              validator: emailValidation,
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 156.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Colors.orange[200],
              ),
            ),
            onPressed: () {
              if (_loginKey.currentState!.validate()) {
                authBloc.add(
                  LoginButtonPressed(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 12),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: const Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Colors.green[200],
              ),
            ),
            onPressed: () {
              authBloc.add(GoToRegister());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 12),
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
        ],
      ),
    );
  }
}
