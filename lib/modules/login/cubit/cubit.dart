import 'package:az_health_care/modules/login/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/end_points.dart';
import '../../../models/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordVisibilityState());
  }

  late ShopLoginModel loginModel;

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
          url: LOGIN,
          data: {'email': email, 'password': password},
        )
        .then((value) {
          loginModel = ShopLoginModel.fromJson(value.data);
          print('==========================================');
          print(loginModel.status);
          // print(loginModel.data!.token);
          // print(loginModel.message);
          print(value.data['message']);
          print('==========================================');
          emit(ShopLoginSuccessState(loginModel));
        })
        .catchError((error) {
          print('==================Error========================');
          print(error.toString());
          print('===================END=======================');
          emit(ShopLoginErrorStates(error.toString()));
        });
  }
}
