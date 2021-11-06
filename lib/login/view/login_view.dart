import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/auth.dart';
import '../login.dart';

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30),
  borderSide: const BorderSide(color: Colors.grey),
  gapPadding: 10,
);

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: BlocProvider(
          create: (context) =>
              LoginBloc(authRepo: context.read<AuthRepository>()),
          child: Center(
            child: _loginForm(),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginInit>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is FormField) {
          _showSnackBar(context, formStatus.toString());
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLogo(),
                    const SizedBox(height: 50.0),
                    _buildUsername(),
                    const SizedBox(height: 10.0),
                    _buildPassword(),
                    const SizedBox(height: 50.0),
                    _buildLoginButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.lock_rounded,
          size: 40,
          color: Colors.grey.shade600,
        ),
        Text(
          "Login App",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade600,
          ),
        )
      ],
    );
  }

  Widget _buildUsername() {
    return BlocBuilder<LoginBloc, LoginInit>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
            hintText: 'Username',
            enabledBorder: outlineInputBorder,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide: const BorderSide(color: Colors.blue),
              gapPadding: 10,
            ),
            border: outlineInputBorder,
          ),
          validator: (value) => state.userValid ? null : "Wrong username",
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginUsernameUpdated(username: value),
              ),
        );
      },
    );
  }

  Widget _buildPassword() {
    return BlocBuilder<LoginBloc, LoginInit>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock),
            hintText: 'Password',
            enabledBorder: outlineInputBorder,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide: const BorderSide(color: Colors.blue),
              gapPadding: 10,
            ),
            border: outlineInputBorder,
          ),
          validator: (value) => state.passValid ? null : "Wrong password",
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginPasswordUpdated(password: value),
              ),
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<LoginBloc, LoginInit>(builder: (context, state) {
      return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<LoginBloc>().add(LoginSubmitted());
          }
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.blue[400],
            fixedSize: const Size(double.maxFinite, 60),
            elevation: 1.0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            )),
        child: state.formStatus is FormSubmitting
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                'Log in',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
      );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
