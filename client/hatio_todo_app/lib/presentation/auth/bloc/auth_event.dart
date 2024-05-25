part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class InitialAuthEvent extends AuthEvent {}

final class GoToRegister extends AuthEvent {}

final class GoToLogin extends AuthEvent {}

final class RegisterButtonPressed extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterButtonPressed({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressed({
    required this.email,
    required this.password,
  });
}

final class LogoutButtonPressed extends AuthEvent {}
