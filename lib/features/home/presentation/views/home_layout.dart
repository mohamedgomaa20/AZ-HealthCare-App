import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/features/get_start/presentation/views/get_start_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/cache_helper.dart';
import '../../data/home_cubit/home_cubit.dart';
import '../../data/home_cubit/home_states.dart';

class HomeLayout extends StatelessWidget {
  static const routeName = "homeLayout";

  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: NavigationBar(
              elevation: 50,
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return TextStyle(color: AppColors.primaryColor);
                }
                return null;
              }),
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              backgroundColor: AppColors.backgroundColor,
              indicatorColor: AppColors.blackColor,
              overlayColor: WidgetStateProperty.all(AppColors.primaryColor),
              destinations: cubit.bottomNavBarItems,
              onDestinationSelected: (index) {
                cubit.changeBottomNav(index);
              },
              selectedIndex: cubit.currentIndex,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // cubit.getUserDataByUserName(userName:"mo_gomaa_m" );
                // print("===============================================");
                // print("===============================================");
                // cubit.getUserDataByUserId(userId:"d9fe7ac7-9075-4885-b272-53af9e963c96" );
                // cubit.getAllUsers();
                // Navigator.pushReplacementNamed(context, GetStartView.routeName);

                CacheHelper.removeData(key: kToken );
                print("===============================================");
                print(CacheHelper.getData(key: kToken));
                print("===============================================");
              },
              child: Icon(Icons.cloud_download),
            ),
          );
        },
      ),
    );
  }
}
