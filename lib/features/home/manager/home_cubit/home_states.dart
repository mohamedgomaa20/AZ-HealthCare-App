 import '../../../Auth/data/models/register_result.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ChangeBottomNavState extends HomeStates {}

class UserLoadingState extends HomeStates {}

class UserLoadedState extends HomeStates {
  final ResultModel user;
  UserLoadedState(this.user);
}

class UserErrorState extends HomeStates {
  final String error;
  UserErrorState(this.error);
}

//get all users


class UsersInitialState extends HomeStates {}

class UsersLoadingState extends HomeStates {}

class UsersLoadedState extends HomeStates {
  final List<ResultModel> users;
  UsersLoadedState(this.users);
}

class UsersErrorState extends HomeStates {
  final String error;
  UsersErrorState(this.error);
}
class ChangeSwitchState extends HomeStates {}

