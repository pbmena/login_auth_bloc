part of 'login_bloc.dart';

class LoginInit {
  final String username;
  final String password;
  final FormStatus formStatus;

  bool get userValid => (username.length > 6) && (username.length < 14);
  bool get passValid => (password.length > 8) && (username.length < 16);

  LoginInit({
    this.username = '',
    this.password = '',
    this.formStatus = const InitFormStatus(),
  });

  LoginInit copyWith({
    String? username,
    String? password,
    FormStatus? formStatus,
  }) {
    return LoginInit(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
