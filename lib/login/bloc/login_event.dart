part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUsernameUpdated extends LoginEvent {
  LoginUsernameUpdated({required this.username});

  final String username;
}

class LoginPasswordUpdated extends LoginEvent {
  LoginPasswordUpdated({required this.password});

  final String password;
}

class LoginSubmitted extends LoginEvent {}
