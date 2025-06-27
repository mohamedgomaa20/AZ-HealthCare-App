import '../../../../../home/data/models/user_model.dart';
import '../../../../domain/models/register_result.dart';

abstract class RegisterStates {}

class RegisterInitial extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final RegisterResult user;

  RegisterSuccessState({required this.user});
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterToggleCreatePasswordVisibilityState extends RegisterStates {}

class RegisterToggleConfirmPasswordVisibilityState extends RegisterStates {}

class RegisterValidationChanged extends RegisterStates {
  final bool isValid;

  RegisterValidationChanged(this.isValid);
}

class RegisterToggleAgreeToTermsState extends RegisterStates {}

class ShowTermsDialogState extends RegisterStates {}
