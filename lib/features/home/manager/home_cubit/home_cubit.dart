import 'package:az_health_care/core/services/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../Auth/data/models/register_result.dart';
import '../../data/models/get_all_user_model.dart';
import '../../data/models/get_user_model.dart';
import '../../presentation/views/home/home_view.dart';
import '../../presentation/views/notification/notification_view.dart';
import '../../presentation/views/profile/profile_view.dart';
import '../../presentation/views/tracker/views/tracker_view.dart';
import '../../presentation/views/vip/vip_view.dart';
import '../../presentation/views/widget/bottom_nav_bar_item.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  bool valueOfSwitch = true;
  bool activation = CacheHelper.getData(key: "valueOfSwitch") ?? false;

  void changeSwitchOfActivation() {
    valueOfSwitch = !valueOfSwitch;
    CacheHelper.saveData(key: "valueOfSwitch", value: valueOfSwitch);
    emit(ChangeSwitchState());
    print(CacheHelper.getData(key: "valueOfSwitch"));
    print("Activation = $activation ");
  }

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    HomeView(),
    const NotificationView(),
    const VipView(),
    const TrackerView(),
    const ProfileView(),
  ];
  List<Widget> bottomNavBarItems = const [
    BottomNavBarItem(iconData: Icons.home, label: 'Home'),
    BottomNavBarItem(iconData: CupertinoIcons.bell, label: 'Notifications'),
    BottomNavBarItem(iconData: CupertinoIcons.star_fill, label: 'VIP'),
    BottomNavBarItem(iconData: CupertinoIcons.location_solid, label: 'Tracker'),
    BottomNavBarItem(iconData: CupertinoIcons.person, label: 'Profile'),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  ///Admin
  ResultModel? userModel;

  void getUserDataByUserId({required String userId}) {
    emit(UserLoadingState());

    print("getUserDataByUserId");
    DioHelper.getData(url: '$GET_USER_BY_ID/$userId')
        .then((value) {
          print(value.data);
          final userResponse = UserResponse.fromJson(value.data);

          if (userResponse.result != null) {
            userModel = userResponse.result!;
            emit(UserLoadedState(userModel!));
          } else {
            final errorMessage =
                userResponse.errors.isNotEmpty
                    ? userResponse.errors.first.toString()
                    : "Unknown error occurred";
            emit(UserErrorState(errorMessage));
          }
        })
        .catchError((error) {
          print(error.toString());
          emit(UserErrorState(error.toString()));
        });
  }

  void getUserDataByUserName({required String userName}) {
    emit(UserLoadingState());
    print("getUserDataByUserName");
    DioHelper.getData(url: '$GET_USER_BY_USERNAME/$userName')
        .then((value) {
          print(value.data);
          final userResponse = UserResponse.fromJson(value.data);

          if (userResponse.result != null) {
            userModel = userResponse.result!;
            emit(UserLoadedState(userModel!));
          } else {
            final errorMessage =
                userResponse.errors.isNotEmpty
                    ? userResponse.errors.first.toString()
                    : "Unknown error occurred";
            emit(UserErrorState(errorMessage));
          }
        })
        .catchError((error) {
          print(error.toString());
          emit(UserErrorState(error.toString()));
        });
  }

  //get all users

  List<ResultModel> allUsers = [];

  void getAllUsers() {
    emit(UsersLoadingState());
    print("getAllUsers");
    DioHelper.getData(url: GET_ALL_USERS)
        .then((value) {
          print(value.data);
          final response = AllUsersResponse.fromJson(value.data);

          if (response.isSuccess) {
            allUsers = response.result;
            emit(UsersLoadedState(allUsers));
          } else {
            final errorMessage =
                response.errors.isNotEmpty
                    ? response.errors.first.toString()
                    : "Unknown error occurred";
            emit(UsersErrorState(errorMessage));
          }
        })
        .catchError((error) {
          emit(UsersErrorState(error.toString()));
        });
  }
}
