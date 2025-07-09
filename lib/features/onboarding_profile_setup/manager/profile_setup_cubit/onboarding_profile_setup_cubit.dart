import 'dart:convert';

import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/sensor_data_upload_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/network/end_points.dart';
import '../../../../../../core/services/cache_helper.dart';
import '../../../../../../core/utils/gender_enum.dart';
import '../../../../../../shared/network/remote/dio_helper.dart';
import '../../../step_tracker_v2/data/database/database_helper.dart';
import '../../../step_tracker_v2/data/models/step_data.dart';
import '../../data/models/update_profile_response_model .dart';
import '../../presentation/views/acitivity_level.dart';
import '../../presentation/views/basic_information.dart';
import '../../presentation/views/gender_view2.dart';
import '../../presentation/views/health_goal.dart';
import '../../presentation/views/physical_information.dart';
import '../../presentation/views/welcome_view.dart';
import 'onboarding_profile_setup_states.dart';

class OnboardingProfileSetupCubit extends Cubit<OnboardingProfileSetupStates> {
  OnboardingProfileSetupCubit() : super(OnboardingProfileSetupInitialState());

  static OnboardingProfileSetupCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? gender;
  String? phoneNumber;

  String? activityLevel;
  String? address;

  String? healthGoal;
  String? age;
  String? height;
  double? weight;

  TimeOfDay? reminderTime;
  int? calculatedCaloriesTarget;
  int? calculatedStepsTarget;

  List<Widget> screenList = [
    WelcomeView(),
    BasicInformation(),
    PhysicalInformation(),
    GenderView2(),
    ActivityLevel(),
    HealthGoal(),
    SensorDataUploadScreen(),
  ];

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  int currentPage = 0;
  late PageController pageController = PageController();

  void updateCurrentPage(int index) {
    currentPage = index;
    emit(OnboardingProfileSetupPageChangedState());
  }

  void notifyInputChanged() {
    emit(OnboardingProfileSetupPageChangedState());
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

  bool canProceed() {
    switch (currentPage) {
      case 0:
        return true;
      case 1:
        return firstName?.isNotEmpty == true && lastName?.isNotEmpty == true;
      case 2:
        return age?.isNotEmpty == true &&
            height?.isNotEmpty == true &&
            weight != 0;
      case 3:
        return gender != null;
      case 4:
        return activityLevel != null;
      case 5:
        return healthGoal != null;
      default:
        return true;
    }
  }

  void updateFirstName(String value) {
    firstName = value.trim();
    emit(OnboardingProfileSetupPageChangedState());
  }

  void updateAddress(String value) {
    address = value.trim();
    emit(OnboardingProfileSetupPageChangedState());
  }

  void updateLastName(String value) {
    lastName = value.trim();

    emit(OnboardingProfileSetupPageChangedState());
  }

  void updatePhoneNumber(String value) {
    phoneNumber = value.trim();
    emit(OnboardingProfileSetupPageChangedState());
  }

  void updateAge(String value) {
    age = value.trim();
    calculateDailyTargets();
    emit(OnboardingProfileSetupPageChangedState());
  }

  void updateWeight(String value) {
    weight = double.parse(value.trim());
    calculateDailyTargets();
    emit(OnboardingProfileSetupPageChangedState());
  }

  void updateHeight(String value) {
    height = value.trim();
    calculateDailyTargets();
    emit(OnboardingProfileSetupPageChangedState());
  }

  void updateGender(String value) {
    gender = value;
    calculateDailyTargets();
    emit(OnboardingProfileSetupSuccessState());
  }

  void updateActivityLevel(String value) {
    activityLevel = value;
    calculateDailyTargets();
    emit(OnboardingProfileSetupSuccessState());
  }

  void updateHealthGoal(String value) {
    healthGoal = value;
    calculateDailyTargets();

    emit(OnboardingProfileSetupSuccessState());
  }

  void nextPage() {
    if (currentPage < screenList.length) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Gender? get selectedGender {
    switch (gender) {
      case 'Male':
        return Gender.male;
      case 'Female':
        return Gender.female;
      case 'PreferNotToSay':
        return Gender.preferNotToSay;
      default:
        return null;
    }
  }

  void calculateDailyTargets() async {
    final double weightKg = weight ?? 0.0;
    final int? ageYears = int.tryParse(age ?? '');

    if (weightKg == 0 ||
        ageYears == null ||
        gender == null ||
        activityLevel == null ||
        healthGoal == null) {
      return;
    }

    double bmr;
    if (gender == 'Male') {
      bmr =
          10 * weightKg + 6.25 * double.parse(height ?? '0') - 5 * ageYears + 5;
    } else {
      bmr =
          10 * weightKg +
          6.25 * double.parse(height ?? '0') -
          5 * ageYears -
          161;
    }

    double activityFactor;
    switch (activityLevel) {
      case "Sedentary":
        activityFactor = 1.2;
        break;
      case "Lightly Active":
        activityFactor = 1.375;
        break;
      case "Moderately Active":
        activityFactor = 1.55;
        break;
      case "Very Active":
        activityFactor = 1.725;
        break;
      case "Extremely Active":
        activityFactor = 1.9;
        break;
      default:
        activityFactor = 1.2;
    }

    double maintenanceCalories = bmr * activityFactor;

    if (healthGoal == "Lose Weight") {
      calculatedCaloriesTarget = (maintenanceCalories - 500).round();
    } else if (healthGoal == "Gain Weight" || healthGoal == "Build Muscle") {
      calculatedCaloriesTarget = (maintenanceCalories + 500).round();
    } else {
      calculatedCaloriesTarget = maintenanceCalories.round();
    }

    calculatedStepsTarget = (activityFactor * 3000).round();

    CacheHelper.saveData(key: 'dailyGoal', value: calculatedStepsTarget);
    print('dailyGoal ${CacheHelper.getData(key: 'dailyGoal')}');

    CacheHelper.saveData(key: 'calculatedCaloriesTarget', value: calculatedCaloriesTarget);
    print('calculatedCaloriesTarget ${CacheHelper.getData(key: 'calculatedCaloriesTarget')}');




    emit(OnboardingProfileSetupSuccessState());
  }

  Future<void> _insertInitialDailyGoal(String userId, int dailyGoal) async {
    final today = DateTime.now();
    final todayStr =
        "${today.year.toString().padLeft(4, '0')}-"
        "${today.month.toString().padLeft(2, '0')}-"
        "${today.day.toString().padLeft(2, '0')}";

    final newStepData = StepData(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      date: todayStr,
      steps: 0,
      caloriesBurned: 0,
      distanceKm: 0.0,
      activeMinutes: 0,
       lastUpdated: DateTime.now(),
    );

    await DatabaseHelper.insertStepData(newStepData);
  }

  Future<void> updateUserProfile() async {
    emit(UpdateProfileLoadingState());

    var id = CacheHelper.getData(key: "id");
    if (id == null) {
      emit(UpdateProfileErrorState("Something went wrong please try login"));
    }
    int? ageValue;
    if (age != null && age.toString().isNotEmpty) {
      ageValue = int.tryParse(age.toString());
    }
    print("=================================");
    print("id: $id");
    print("=================================");
    try {
      final response = await DioHelper.putData(
        url: "$UPDATE_PROFILE$id",
        data: {
          "id": id,
          "firstName": firstName,
          "lastName": lastName,
          "name": "$firstName $lastName",
          "phoneNumber": phoneNumber,
          "address": address ?? "",
          "age": age,
          "dateOfBirth": "2025-07-06T08:45:59.334Z",
          "gender": gender,
          "weightKg": weight,
          "height": height,
          "healthGoals": healthGoal,
          "updatedAt": "2025-07-06T08:45:59.334Z",
        },
      );
      print("================= success ===================");
      print(response.data);
      print(response.data.statusCode);
      print(response.data.statusMessage);
      print(response.data.data);
      updatedProfileResponse = UpdateProfileResponse.fromJson(
        response.data.data,
      );
      print("===================data==========================");
      // updatedProfileResponse = UpdateProfileResponse.fromJson(value.data);
      if (response.data.statusCode == 200 ||
          response.data.statusCode == 204 &&
              updatedProfileResponse?.result != null) {
        userProfileResult = updatedProfileResponse?.result!;
        emit(UpdateProfileSuccessState(userProfileResult));

        print("dailyGoal:${CacheHelper.getData(key: 'dailyGoal')} ");
        print("dailyGoal: ");
        print(CacheHelper.getData(key: 'dailyGoal'));


        print("====================end of data=========================");
      } else {
        print("Failed with status: ${response.data..statusCode}");
        emit(
          UpdateProfileErrorState("Server error: ${response.data..statusCode}"),
        );
      }
    } catch (error) {
      print("================= error ===================");
      emit(UpdateProfileErrorState(error.toString()));

      print(error.toString());
      print("=============================================");
    }
  }

  void clearData() {
    currentPage = 0;
    pageController.dispose();
    pageController = PageController();

    firstName = null;
    firstNameController.clear();

    lastName = null;
    lastNameController.clear();

    gender = null;

    phoneNumber = null;
    phoneNumberController.clear();

    activityLevel = null;

    address = null;
    addressController.clear();

    healthGoal = null;
    age = null;
    ageController.clear();

    height = null;
    heightController.clear();
    weight = null;
    weightController.clear();
    reminderTime = null;
    calculatedCaloriesTarget = null;
    calculatedStepsTarget = null;
    emit(OnboardingProfileSetupClearState());
  }

  void resetCubit() {
    currentPage = 0;
    pageController = PageController();
    clearData();
    emit(OnboardingProfileSetupInitialState());
  }
}
