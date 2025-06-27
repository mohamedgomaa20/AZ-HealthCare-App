import 'package:az_health_care/core/network/end_points.dart';
 import 'package:az_health_care/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/register_response.dart';
import '../../../../domain/models/register_result.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isCreatePassword = true;
  bool isConfirmPassword = true;
  IconData suffixIconCreatePassword = Icons.visibility;
  IconData suffixIconConfirmPassword = Icons.visibility;

  void toggleCreatePasswordVisibility() {
    isCreatePassword = !isCreatePassword;
    suffixIconCreatePassword =
        isCreatePassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterToggleCreatePasswordVisibilityState());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPassword = !isConfirmPassword;
    suffixIconConfirmPassword =
        isConfirmPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterToggleConfirmPasswordVisibilityState());
  }

  /////////////////////////////////////
  void requestShowTermsDialog() {
    emit(ShowTermsDialogState());
  }

  /////////////////////////////////////

  String _userName = '';
  String _email = '';
  String _createPassword = '';
  String _confirmPassword = '';

  bool get isFormValid =>
      _isEmailValid(_email) &&
      _isPasswordValid(_createPassword) &&
      _isPasswordValid(_confirmPassword) &&
      _isConfirmPasswordMatched();

  void onUserNameChanged(String value) {
    _userName = value;
    emit(RegisterValidationChanged(isFormValid));
  }

  void onEmailChanged(String value) {
    _email = value;
    emit(RegisterValidationChanged(isFormValid));
  }

  void onCreatePasswordChanged(String value) {
    _createPassword = value;
    emit(RegisterValidationChanged(isFormValid));
  }

  void onConfirmPasswordChanged(String value) {
    _confirmPassword = value;
    emit(RegisterValidationChanged(isFormValid));
  }

  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$').hasMatch(password);
  }

  bool _isConfirmPasswordMatched() {
    return _createPassword == _confirmPassword;
  }

  /////////////////////////////////////
  /////////////////////////////////////
  bool isAgreeToTerms = false;

  void toggleAgreeToTerms() {
    isAgreeToTerms = !isAgreeToTerms;
    emit(RegisterToggleAgreeToTermsState());
  }

  void acceptTermsAndConditions() {
    isAgreeToTerms = true;
    emit(RegisterToggleAgreeToTermsState());
  }

  ////////////////////////////////////
  ////////////////////////////////////

  RegisterResponse? registerResponse;
  RegisterResult? userModel;

  void userRegister({
    required String email,
    required String password,
    required String userName,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(
          url: REGISTER,
          data: {
            'email': email,
            'password': password,
            'userName': userName,
            'role': 0,
          },
        )
        .then((value) {
          print(
            "====================== Register Response ======================",
          );
          print(value.data);
          print("======================================");

          registerResponse = RegisterResponse.fromJson(value.data);

          if (registerResponse!.isSuccess && registerResponse!.result != null) {
            userModel = registerResponse!.result;

            print("=======================");
            print(userModel);
            print("=======================");

            emit(RegisterSuccessState(user: userModel!));
          } else {
            final errorMessage =
                registerResponse!.errors.isNotEmpty
                    ? registerResponse!.errors.first.toString()
                    : "Register failed. Please try again.";

            print("=======================");
            print(errorMessage);
            print("=======================");

            emit(RegisterErrorState(errorMessage));
          }
        })
        .catchError((error) {
          print("=======================");
          print("Register Error: $error");
          emit(RegisterErrorState("An error occurred. Please try again."));
          print("=======================");
        });
  }


}
