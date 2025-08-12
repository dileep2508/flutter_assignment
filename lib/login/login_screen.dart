import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home/home_screen.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) =>
                    context.read<LoginBloc>().add(EmailChanged(value)),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) =>
                    context.read<LoginBloc>().add(PasswordChanged(value)),
              ),
              SizedBox(height: 20),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.isValid
                        ? () => context.read<LoginBloc>().add(LoginSubmitted())
                        : null,
                    child: state.isSubmitting
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Submit'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
