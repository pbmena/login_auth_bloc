abstract class FormStatus {
  const FormStatus();
}

class InitFormStatus extends FormStatus {
  const InitFormStatus();
}

class FormSubmitting extends FormStatus {}

class FormSuccess extends FormStatus {}

class FormFailed extends FormStatus {
  FormFailed(this.exception);
  final Exception exception;
}
