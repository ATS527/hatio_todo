part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthIdle extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User? user;

  AuthSuccess({this.user});
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});
}

final class AuthRegister extends AuthState {}

final class AuthLogin extends AuthState {}
