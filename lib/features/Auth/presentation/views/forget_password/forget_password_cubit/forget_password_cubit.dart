import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/network/end_points.dart';
import '../../../../../../../shared/network/remote/dio_helper.dart';
import 'forgot_password_states.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());

  static ForgotPasswordCubit get(context) => BlocProvider.of(context);

  String _email = '';

  bool get isEmailValid => _isEmailValid(_email);

  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void onEmailChanged(String value) {
    _email = value;
    emit(ForgetPasswordValidationChanged(isEmailValid));
  }

  void sendResetEmail(String email) {
    emit(ForgotPasswordLoadingState());
    DioHelper.postData(url: FORGOT_PASSWORD, query: {'email': email})
        .then((value) {
          final message = value.data.toString();
          print("===================================");
          print("Reset email response: $message");
          print("===================================");
          if (message == "Password reset email sent.") {
            emit(ForgotPasswordSuccessState(message));
          } else {
            emit(ForgotPasswordErrorState(message));
          }
        })
        .catchError((error) {
          print("===================================");
          print("Error sending reset email: $error");
          print("===================================");
          emit(
            ForgotPasswordErrorState("Something went wrong. Please try again."),
          );
        });
  }





}
