import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      // Replace this with your login logic
      await Future.delayed(Duration(seconds: 2));

      // If login is successful
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: 'Login failed: $e'));
    }
  }
}
