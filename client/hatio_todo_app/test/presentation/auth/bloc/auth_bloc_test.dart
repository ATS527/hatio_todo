import 'package:flutter_test/flutter_test.dart';
import 'package:hatio_todo_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group("All Authentication Tests", () {
    blocTest(
      "register success with new email",
      build: () => AuthBloc(),
      wait: const Duration(seconds: 1),
      act: (bloc) => bloc.add(
        RegisterButtonPressed(
          name: "Anonymous",
          email: "newUser@gmail.com",
          password: "strongPassword#123",
        ),
      ),
      expect: () => [AuthLoading(), AuthSuccess()],
    );

    blocTest(
      "register failure to already existing email",
      build: () => AuthBloc(),
      wait: const Duration(seconds: 1),
      act: (bloc) => bloc.add(
        RegisterButtonPressed(
          name: "New Name",
          email: "newUser@gmail.com",
          password: "strongishPassword#123456",
        ),
      ),
      expect: () => [
        AuthLoading(),
        AuthFailure(
          message: "User already exists",
        ),
      ],
    );

    blocTest(
      "login success with registered email",
      build: () => AuthBloc(),
      wait: const Duration(seconds: 1),
      act: (bloc) => bloc.add(
        LoginButtonPressed(
          email: "newUser@gmail.com",
          password: "strongPassword#123",
        ),
      ),
      expect: () => [AuthLoading(), AuthSuccess()],
    );

    blocTest(
      "login failure with invalid email or password",
      build: () => AuthBloc(),
      wait: const Duration(seconds: 1),
      act: (bloc) => bloc.add(
        LoginButtonPressed(
          email: "newUser@gmail.com",
          password: "unknownPassword#12345",
        ),
      ),
      expect: () => [
        AuthLoading(),
        AuthFailure(
          message: "Invalid email or password",
        ),
      ],
    );

    blocTest(
      "logout success with valid user logged in",
      build: () => AuthBloc(),
      wait: const Duration(seconds: 1),
      act: (bloc) => bloc.add(LogoutButtonPressed()),
      expect: () => [AuthLoading(), AuthInitial()],
    );
  });
}
