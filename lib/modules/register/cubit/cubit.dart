 import 'package:az_health_care/modules/register/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/end_points.dart';
import '../../../models/register_model.dart';
import '../../../shared/network/remote/dio_helper/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

  late ShopRegisterModel registerModel;

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
          path: REGISTER,
          data: {
            'name': name,
            'phone': phone,
            'email': email,
            'password': password,
          },
        )
        .then((value) {
          registerModel = ShopRegisterModel.fromJson(value.data);
          print('=================register success=========================');
          print(registerModel.status);
          // print(loginModel.data!.token);
          // print(loginModel.message);
          print(value.data['message']);
          print('==========================================');
          emit(ShopRegisterSuccessState(registerModel));
        })
        .catchError((error) {
          print('==================Register Error========================');
          print(error.toString());
          print('===================END=======================');
          emit(ShopRegisterErrorStates(error.toString()));
        });
  }
}
