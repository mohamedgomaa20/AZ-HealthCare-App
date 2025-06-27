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

//get all users
// --- User States ---


class UsersInitialState extends HomeStates {}

class UsersLoadingState extends HomeStates {}

class UsersLoadedState extends HomeStates {
  final List<UserModel> users;
  UsersLoadedState(this.users);
}

class UsersErrorState extends HomeStates {
  final String error;
  UsersErrorState(this.error);
}

