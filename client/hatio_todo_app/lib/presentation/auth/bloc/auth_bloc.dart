import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hatio_todo_app/data/model/user.dart';
import 'package:hatio_todo_app/data/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository = UserRepository();

  AuthBloc() : super(AuthInitial()) {
    on<InitialAuthEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        User? user = await _userRepository.getUser();
        emit(AuthSuccess(user: user));
      } catch (e) {
        emit(AuthIdle());
      }
    });
    
    on<RegisterButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        User user = await _userRepository.registerUser(
          event.name,
          event.email,
          event.password,
        );
        emit(AuthSuccess(user: user));
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    });

    on<LoginButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        User user = await _userRepository.loginUser(
          event.email,
          event.password,
        );
        emit(AuthSuccess(user: user));
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    });

    on<LogoutButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        bool isLoggedOut = await _userRepository.logoutUser();
        if (isLoggedOut) {
          emit(AuthInitial());
        } else {
          emit(AuthSuccess());
        }
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    });

    on<GoToLogin>((event, emit) {
      emit(AuthLogin());
    });

    on<GoToRegister>((event, emit) {
      emit(AuthRegister());
    });
  }
}

final authBloc = AuthBloc();
