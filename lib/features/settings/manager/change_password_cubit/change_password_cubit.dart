import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/network/end_points.dart';
import '../../../../../../shared/network/remote/dio_helper.dart';
import '../../../../core/services/cache_helper.dart';
import 'change_password_states.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStates> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  bool isCurrentPassword = true;
  bool isNewPassword = true;
  bool isConfirmPassword = true;
  IconData suffixIconCurrentPassword = Icons.visibility;
  IconData suffixIconNewPassword = Icons.visibility;
  IconData suffixIconConfirmPassword = Icons.visibility;

  void toggleNewPasswordVisibility() {
    isNewPassword = !isNewPassword;
    suffixIconNewPassword =
        isNewPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordToggleNewPasswordVisibilityState());
  }

  void toggleCurrentPasswordVisibility() {
    isCurrentPassword = !isCurrentPassword;
    suffixIconCurrentPassword =
        isCurrentPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordToggleCurrentPasswordVisibilityState());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPassword = !isConfirmPassword;
    suffixIconConfirmPassword =
        isConfirmPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordToggleConfirmPasswordVisibilityState());
  }

  /////////////////////////////////////

  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  bool get isFormValid =>
      _currentPassword.isNotEmpty &&
      _isPasswordValid(_newPassword) &&
      _isPasswordValid(_confirmPassword) &&
      _isConfirmPasswordMatched();

  void onCurrentPasswordChanged(String value) {
    _currentPassword = value;
    emit(ChangePasswordValidationChanged(isFormValid));
  }

  void onNewPasswordChanged(String value) {
    _newPassword = value;
    emit(ChangePasswordValidationChanged(isFormValid));
  }

  void onConfirmPasswordChanged(String value) {
    _confirmPassword = value;
    emit(ChangePasswordValidationChanged(isFormValid));
  }

  bool _isPasswordValid(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$').hasMatch(password);
  }

  bool _isConfirmPasswordMatched() {
    return _newPassword == _confirmPassword;
  }

  void changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) {
    emit(ChangePasswordLoadingState());
    DioHelper.postData(
          url: CHANGE_PASSWORD,
          data: {
            'email': email,
            "currentPassword": currentPassword,
            "newPassword": newPassword,
          },
        )
        .then((value) {
          final message = value.data.toString();
          print("===================================");
          print("Message Change Password : $message");
          print("===================================");
          if (message == "Password Changed Correctly") {
            emit(ChangePasswordSuccessState(message));
            print("===================================");
          } else {
            print("===================================");
            print("Error Change Password : $message");
            emit(ChangePasswordErrorState(message));
          }
        })
        .catchError((error) {
          print("===================================");
          print("Error Change Password : $error");
          print("===================================");
          emit(
            ChangePasswordErrorState("Something went wrong. Please try again."),
          );
        });
  }



  // void deleteAccount() {
  //   var id = CacheHelper.getData(key: 'id');
  //   if (id == null) {
  //     emit(DeleteAccountErrorState("User not found. Please login again."));
  //     return;
  //   }
  //   emit(DeleteAccountLoadingState());
  //   DioHelper.postData(url: "$DELETE_ACCOUNT$id")
  //       .then((value) {
  //     print("===================================");
  //     print("Delete Account Response: ${value.data}");
  //     print("Status Code: ${value.statusCode}");
  //     print("===================================");
  //         final message = value.data.toString();
  //         if (value.statusCode == 200 &&
  //             message == "user deleted successfully.") {
  //           print("===================================");
  //           print("Message Delete Account : $message");
  //           print("===================================");
  //         }
  //         if (message == "user deleted successfully.") {
  //           emit(DeleteAccountSuccessState(message));
  //           print("===================================");
  //         } else {
  //           print("===================================");
  //           print("Error Delete Account : $message");
  //           emit(DeleteAccountErrorState(message));
  //         }
  //       })
  //       .catchError((error) {
  //         print("===================================");
  //         print("Error Delete Account : $error");
  //         print("===================================");
  //         emit(
  //           DeleteAccountErrorState("Something went wrong. Please try again."),
  //         );
  //       });
  // }
}
