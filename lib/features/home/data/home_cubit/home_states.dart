import '../models/user_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ChangeBottomNavState extends HomeStates {}

class UserLoadingState extends HomeStates {}

class UserLoadedState extends HomeStates {
  final UserModel user;
  UserLoadedState(this.user);
}

class UserErrorState extends HomeStates {
  final String error;
  UserErrorState(this.error);
}
