import 'package:flutter/material.dart';
import 'package:hatio_todo_app/presentation/auth/bloc/auth_bloc.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: emailValidation,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
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
              child: const Text('Login'),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                authBloc.add(GoToRegister());
              },
              child: const Text('Register'),
            ),
          ),
        ],
      ),
    );
  }
}
