import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../auth/auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginInit> {
  LoginBloc({required this.authRepo}) : super(LoginInit());
  final AuthRepository authRepo;

  @override
  Stream<LoginInit> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameUpdated) {
      yield* _mapLoginUsernameUpdatedToState(event);
    } else if (event is LoginPasswordUpdated) {
      yield* _mapLoginPasswordUpdatedToState(event);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event);
    }
  }

  Stream<LoginInit> _mapLoginUsernameUpdatedToState(
    LoginUsernameUpdated event,
  ) async* {
    yield state.copyWith(username: event.username);
  }

  Stream<LoginInit> _mapLoginPasswordUpdatedToState(
    LoginPasswordUpdated event,
  ) async* {
    yield state.copyWith(password: event.password);
  }

  Stream<LoginInit> _mapLoginSubmittedToState(
    LoginSubmitted event,
  ) async* {
    yield state.copyWith(formStatus: FormSubmitting());

    try {
      await authRepo.login(
        username: state.username,
        password: state.password,
      );
      yield state.copyWith(formStatus: FormSuccess());
    } catch (e) {
      yield state.copyWith(formStatus: FormFailed(Exception(e)));
    }
  }
}
