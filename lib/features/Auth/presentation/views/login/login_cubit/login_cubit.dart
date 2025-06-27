import 'package:az_health_care/core/network/end_points.dart';
import 'package:az_health_care/features/home/data/models/user_model.dart';
import 'package:az_health_care/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/services/cache_helper.dart';
import '../../../../domain/models/login_response.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility;

  void togglePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(LoginTogglePasswordVisibilityState());
  }

  /////////////////////////////////////
  /////////////////////////////////////

  String _email = '';
  String _password = '';

  bool get isFormValid => _isEmailValid(_email) && _isPasswordValid(_password);

  void onEmailChanged(String value) {
    _email = value;
    emit(LoginValidationChanged(isFormValid));
  }

  void onPasswordChanged(String value) {
    _password = value;
    emit(LoginValidationChanged(isFormValid));
  }

  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$').hasMatch(password);
  }

  /////////////////////////////////////
  /////////////////////////////////////
  bool isRememberMe = false;

  void toggleRememberMe() {
    isRememberMe = !isRememberMe;
    emit(LoginToggleRememberMeState());
  }

  LoginResponse? loginResponse;

  UserModel? userModel;

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
          print("=========== Login Response ===========");
          print(value.data);
          print("======================================");

          final loginResponse = LoginResponse.fromJson(value.data);
          if (loginResponse.isSuccess && loginResponse.result != null) {
            final user = loginResponse.result!.user;
            final token = loginResponse.result!.token;

            CacheHelper.saveData(key: kToken, value: token);

            emit(LoginSuccessState(user: user));
          } else {
            final errorMessage =
                loginResponse.errors.isNotEmpty
                    ? loginResponse.errors.first.toString()
                    : "Login failed. Please try again.";
            emit(LoginErrorState(errorMessage));
          }
        })
        .catchError((error) {
          print("Login Error: $error");
          emit(LoginErrorState("An error occurred. Please try again."));
        });
  }
}
