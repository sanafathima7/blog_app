import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_bloc/screens/bloc/register_state.dart';
import 'package:hive_bloc/screens/bloc/register_event.dart';

import 'package:hive_bloc/models/user.dart' as userPackage;

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupButtonPressed>(_onSignupButtonPressed);
  }

  Future<void> _onSignupButtonPressed(
      SignupButtonPressed event, Emitter<SignupState> emit) async {
    emit(SignupLoading());

    try {
      var box = await Hive.openBox<userPackage.userList>('userdata');
      var newUser = userPackage.userList(
        username: event.username,
        email: event.email,
        password: event.password,
      );

      await box.add(newUser);
      await box.close();

      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure(error: 'Error saving user data: $e'));
    }
  }
}
