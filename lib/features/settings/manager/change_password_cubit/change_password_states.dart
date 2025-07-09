abstract class ChangePasswordStates {}

class ChangePasswordInitialState extends ChangePasswordStates {}

class ChangePasswordLoadingState extends ChangePasswordStates {}

class ChangePasswordToggleConfirmPasswordVisibilityState
    extends ChangePasswordStates {}

class ChangePasswordToggleNewPasswordVisibilityState
    extends ChangePasswordStates {}

class ChangePasswordToggleCurrentPasswordVisibilityState
    extends ChangePasswordStates {}

class ChangePasswordSuccessState extends ChangePasswordStates {
  final String message;

  ChangePasswordSuccessState(this.message);
}

class ChangePasswordErrorState extends ChangePasswordStates {
  final String error;

  ChangePasswordErrorState(this.error);
}

class ChangePasswordValidationChanged extends ChangePasswordStates {
  final bool isEmailValid;

  ChangePasswordValidationChanged(this.isEmailValid);
}

