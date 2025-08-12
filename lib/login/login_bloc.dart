import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/validators.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<EmailChanged>((event, emit) {
      final isValid = Validators.isValidEmail(event.email) &&
          Validators.isValidPassword(state.password);
      emit(state.copyWith(email: event.email, isValid: isValid));
    });

    on<PasswordChanged>((event, emit) {
      final isValid = Validators.isValidEmail(state.email) &&
          Validators.isValidPassword(event.password);
      emit(state.copyWith(password: event.password, isValid: isValid));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false));
      await Future.delayed(Duration(seconds: 1)); // Simulate API call

      if (state.isValid) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    });
  }
}
