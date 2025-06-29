import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SendEmailStates {}

class SendEmailInitialState extends SendEmailStates {}

class SendEmailLoadingState extends SendEmailStates {}

class SendEmailSuccessState extends SendEmailStates {}

class SendEmailErrorState extends SendEmailStates {
  final String error;
  SendEmailErrorState(this.error);
}

class SendEmailValidationChanged extends SendEmailStates {
  final bool isValid;
  SendEmailValidationChanged(this.isValid);
}









