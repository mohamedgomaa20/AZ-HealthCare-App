import 'package:az_health_care/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/home_model.dart';
import '../../../models/login_model.dart';
import '../../../modules/settings/settings_screen.dart';
import '../../../shared/styles/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = [
    ShopSettingsScreen(),
    ShopSettingsScreen(),
    ShopSettingsScreen(),
    ShopSettingsScreen(),
  ];
  List<BottomNavigationBarItem> bottomNavBarItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  // void getHomeData() {
  //   print('==================token=================');
  //   print(token);
  //   print('========================================');
  //   emit(ShopLoadingHomeDataState());
  //   DioHelper.getData(path: HOME, token: token)
  //       .then((value) {
  //         homeModel = HomeModel.fromJson(value.data);
  //         homeModel!.data!.products.forEach((element) {
  //           favorites.addAll({element.id!: element.inFavorites!});
  //         });
  //         // print('==================favorite========================');
  //         // print(favorites);
  //         // print('==================end fav========================');
  //         // print('==================Home Model========================');
  //         // printFullText(value.data);
  //         // print(homeModel!.status);
  //         // print(homeModel!.data!.banners[2].image);
  //         // print(value.data['data']);
  //         // print('==========================================');
  //         emit(ShopSuccessHomeDataState());
  //       })
  //       .catchError((error) {
  //         //   print('==================Error========================');
  //         //   print(error.toString());
  //         //   print('===================END=======================');
  //         emit(ShopErrorHomeDataState(error.toString()));
  //       });
  // }

  ShopLoginModel? userModel;

  // void getUserData() {
  //   emit(ShopLoadingUserDataState());
  //   DioHelper.getData(path: PROFILE, token: token)
  //       .then((value) {
  //         userModel = ShopLoginModel.fromJson(value.data);
  //         print('==================User Model========================');
  //         print(userModel!.data!.name);
  //         print(userModel!.data!.email);
  //         print(userModel!.data!.phone);
  //         print(userModel!.data!.token);
  //         emit(ShopSuccessUserDataState(userModel!));
  //         print('============================================================');
  //       })
  //       .catchError((error) {
  //         print('==================User Error========================');
  //         emit(ShopErrorUserDataState(error.toString()));
  //         print('============================================================');
  //       });
  // }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
  }) {
    print("object");
    // emit(ShopLoadingUpdateUserState());
    // DioHelper.putData(
    //       path: UPDATE_PROFILE,
    //       token: token,
    //       data: {'name': name, 'phone': phone, 'email': email},
    //     )
    //     .then((value) {
    //       if (value.data['status'] == true) {
    //         userModel = ShopLoginModel.fromJson(value.data);
    //         emit(ShopSuccessUpdateUserState(userModel!));
    //       } else {
    //         String errorMessage =
    //             value.data['message'] ??
    //             'Something went wrong while updating your profile';
    //         emit(ShopErrorUpdateUserState(errorMessage));
    //       }
    //       print(
    //         '==================Update Profile Model========================',
    //       );
    //       print(userModel?.status);
    //       print(userModel?.message);
    //       print(userModel?.data!.name);
    //       print(userModel?.data!.phone);
    //       print(userModel?.data!.email);
    //       print('============================================================');
    //     })
    //       .catchError((error) {
    //         print(
    //           '==================Update Profile Error========================',
    //         );
    //         emit(ShopErrorUpdateUserState(error.toString()));
    //         print('============================================================');
    //       });
  }

  int currentCarouselIndex = 0;

  void changeCarouselIndex(int index) {
    currentCarouselIndex = index;
    emit(ProductDetailsCarouselIndexState());
  }

  Map<int, int> currentCarouselIndices = {};

  void changeCarouselIndexInHome(int index, int productId) {
    currentCarouselIndices[productId] = index;
    emit(ShopChangeCarouselIndexState());
  }
}
