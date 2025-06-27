import 'package:az_health_care/core/network/end_points.dart';
import 'package:az_health_care/features/home/data/models/user_model.dart';
import 'package:az_health_care/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/services/cache_helper.dart';
import '../../../../domain/models/login_respose.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void togglePasswordVisibility() {
    isPassword = !isPassword;
    emit(LoginTogglePasswordVisibilityState());
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

            CacheHelper.setData(key: 'token', value: token);

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
