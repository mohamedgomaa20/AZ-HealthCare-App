import '../../../../../home/data/models/user_model.dart';

abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final UserModel user;
  LoginSuccessState({required this.user});
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginTogglePasswordVisibilityState extends LoginStates {}

class LoginValidationChanged extends LoginStates{
  final bool isValid;
  LoginValidationChanged(this.isValid);
}
class LoginToggleRememberMeState extends LoginStates {}