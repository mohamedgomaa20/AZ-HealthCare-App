import 'package:az_health_care/features/onboarding_profile_setup/presentation/data/profile_setup_cubit/onboarding_profile_setup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingProfileSetupCubit extends Cubit<OnboardingProfileSetupStates> {
  OnboardingProfileSetupCubit() : super(OnboardingProfileSetupInitialState());

  static OnboardingProfileSetupCubit get(context) => BlocProvider.of(context);

  String? gender;
  DateTime? birthday;
  int? height;
  int? weight;
  TimeOfDay? reminderTime;

  int currentPage = 0;
  late PageController pageController=PageController() ;

  void updateCurrentPage(int index) {
    currentPage = index;
    emit(OnboardingProfileSetupPageChangedState());
  }


  void goToNextPage(int pageCount) {
    if (currentPage < pageCount - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      updateCurrentPage(currentPage + 1);
    } else {
      submitUserData();
    }
  }
  void goToPreviousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      updateCurrentPage(currentPage - 1);
    }
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  void updateGender(String value) {
    gender = value;
    emit(OnboardingProfileSetupSuccessState());
  }
  void updateBirthday(DateTime date) {
    birthday = date;
    emit(OnboardingProfileSetupSuccessState());
  }

  void updateHeight(int value) {
    height = value;
    emit(OnboardingProfileSetupSuccessState());
  }

  void updateWeight(int value) {
    weight = value;
    emit(OnboardingProfileSetupSuccessState());
  }

  void updateReminderTime(TimeOfDay value) {
    reminderTime = value;
    emit(OnboardingProfileSetupSuccessState());
  }

  void submitUserData1() {
    emit(OnboardingProfileSetupLoadingState());

    try {
      print('gender: $gender');
      print('birthday: $birthday');
      print('height: $height');
      print('weight: $weight');
      print('reminderTime: $reminderTime');

      emit(OnboardingProfileSetupSuccessState());
    } catch (e) {
      emit(OnboardingProfileSetupErrorState(e.toString()));
    }
  }

  Future<void> submitUserData() async {
    emit(OnboardingProfileSetupLoadingState());

    try {
      await Future.delayed(Duration(seconds: 3));

      if (gender == null ||
          birthday == null ||
          weight == null ||
          height == null ||
          reminderTime == null) {
        emit(OnboardingProfileSetupErrorState("Please complete all fields."));
        return;
      }

      emit(OnboardingProfileSetupSuccessState());
    } catch (e) {
      emit(OnboardingProfileSetupErrorState(e.toString()));
    }
  }
}
