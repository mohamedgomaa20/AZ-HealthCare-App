
import '../../../models/register_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopRegisterModel registerModel;
  ShopRegisterSuccessState(this.registerModel);
}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterErrorStates extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorStates(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}
