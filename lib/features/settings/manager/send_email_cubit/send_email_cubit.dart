import 'package:az_health_care/core/network/end_points.dart';
import 'package:az_health_care/features/settings/manager/send_email_cubit/send_email_states.dart';
import 'package:az_health_care/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendEmailCubit extends Cubit<SendEmailStates> {
  SendEmailCubit() : super(SendEmailInitialState());

  static SendEmailCubit get(context) => BlocProvider.of(context);

  bool isFormValid = false;
  List<String> attachments = [];
  String toEmail = '';
  String subject = '';
  String body = '';

  void onToEmailChanged(String value) {
    toEmail = value.trim();
    _validateForm();
  }

  void onSubjectChanged(String value) {
    subject = value.trim();
    _validateForm();
  }

  void onBodyChanged(String value) {
    body = value.trim();
    _validateForm();
  }

  void _validateForm() {
    bool isEmailValid = _isValidEmail(toEmail);
    bool isSubjectValid = subject.length >= 3;
    bool isBodyValid = body.length >= 10;
    isFormValid = isEmailValid && isSubjectValid && isBodyValid;
    emit(SendEmailValidationChanged(isFormValid));
  }

  bool _isValidEmail(String email) {
    if (email.isEmpty) return false;
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  void addAttachment(String filePath) {
    attachments.add(filePath);
    emit(SendEmailValidationChanged(isFormValid));
  }

  void removeAttachment(int index) {
    attachments.removeAt(index);
    emit(SendEmailValidationChanged(isFormValid));
  }

  void sendEmail({
    required String toEmail,
    required String subject,
    required String body,
  }) {
    if (toEmail.trim().isEmpty ||
        subject.trim().isEmpty ||
        body.trim().isEmpty) {
      emit(SendEmailErrorState("Please fill in all fields"));
      return;
    }

    emit(SendEmailLoadingState());

    final formData = FormData.fromMap({
      'ToEmail': toEmail.trim(),
      'Subject': subject.trim(),
      'Body': body.trim(),
      'attachments':
          attachments.map((path) {
            return MultipartFile.fromFileSync(path);
          }).toList(),
    });

    DioHelper.postData(url: SEND_EMAIL, data: formData)
        .then((value) {
          print("Response: ${value.data}");
          if (value.statusCode == 200) {
            print("===================================");
            print("Email sent successfully");
            print("Response: ${value.data}");
            print("===================================");
            emit(SendEmailSuccessState());
          } else {
            emit(SendEmailErrorState("Failed to send email"));
          }
        })
        .catchError((error) {
          print("===================================");
          print("Error sending email: $error");
          print("===================================");

          emit(SendEmailErrorState(error.toString()));
        });
  }

  void clearForm() {
    toEmail = '';
    subject = '';
    body = '';
    attachments.clear();
    isFormValid = false;
    emit(SendEmailInitialState());
  }
}
