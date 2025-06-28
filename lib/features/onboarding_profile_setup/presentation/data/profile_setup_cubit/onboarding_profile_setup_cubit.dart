import 'package:az_health_care/features/onboarding_profile_setup/presentation/data/profile_setup_cubit/onboarding_profile_setup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../views/widgets/gender_view.dart';

class OnboardingProfileSetupCubit extends Cubit<OnboardingProfileSetupStates> {
  OnboardingProfileSetupCubit() : super(OnboardingProfileSetupInitialState());

  static OnboardingProfileSetupCubit get(context) => BlocProvider.of(context);

  String? gender;
  DateTime? birthday;
  int? height;
  int? weight;
  TimeOfDay? reminderTime;

  int currentPage = 0;
  late PageController pageController = PageController();

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

  ///gender view
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

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////

  /// birthday view
  /////////////////
  int currentDayIndex = 0;
  int currentMonthIndex = 0;
  int currentYearIndex = 0;

  late FixedExtentScrollController monthController;
  late FixedExtentScrollController dayController;
  late FixedExtentScrollController yearController;

  List<String> days = [];
  final List<String> months = List.generate(
    12,
    (i) => (i + 1).toString().padLeft(2, '0'),
  );
  final List<String> years = List.generate(
    100,
    (i) => (DateTime.now().year - 99 + i).toString(),
  );

  //
  void initBirthdayControllers() {
    birthday = birthday ?? DateTime(2000, 1, 1);
    int selectedDay = birthday!.day;
    int selectedMonth = birthday!.month;
    int selectedYear = birthday!.year;

    days = _calculateDaysInMonth(selectedYear, selectedMonth);

    int monthIndex = selectedMonth - 1;
    int dayIndex = selectedDay - 1;
    int yearIndex = years.indexOf(selectedYear.toString());

    monthController = FixedExtentScrollController(initialItem: monthIndex);
    dayController = FixedExtentScrollController(initialItem: dayIndex);
    yearController = FixedExtentScrollController(initialItem: yearIndex);
  }

  List<String> _calculateDaysInMonth(int year, int month) {
    final totalDays = DateTime(year, month + 1, 0).day;
    return List.generate(totalDays, (i) => (i + 1).toString().padLeft(2, '0'));
  }

  //
  void onMonthChanged(int index) {
    currentMonthIndex = index; // أضف ده
    final newMonth = int.parse(months[index]);
    final current = birthday ?? DateTime.now();
    birthday = DateTime(current.year, newMonth, current.day);

    days = _calculateDaysInMonth(current.year, newMonth);
    currentDayIndex = (birthday!.day - 1).clamp(0, days.length - 1);
    emit(OnboardingProfileSetupSuccessState());
  }

  void onDayChanged(int index) {
    currentDayIndex = index; // أضف ده
    final current = birthday ?? DateTime.now();
    final newDay = int.parse(days[index]);
    birthday = DateTime(current.year, current.month, newDay);
    emit(OnboardingProfileSetupSuccessState());
  }

  void onYearChanged(int index) {
    currentYearIndex = index; // أضف ده
    final newYear = int.parse(years[index]);
    final current = birthday ?? DateTime.now();
    birthday = DateTime(newYear, current.month, current.day);

    days = _calculateDaysInMonth(newYear, current.month);
    currentDayIndex = (birthday!.day - 1).clamp(0, days.length - 1);
    emit(OnboardingProfileSetupSuccessState());
  }

  void jumpToSelectedBirthdayItems() {
    if (birthday != null) {
      currentDayIndex = birthday!.day - 1;
      currentMonthIndex = birthday!.month - 1;
      currentYearIndex = years.indexOf(birthday!.year.toString());

      dayController.jumpToItem(currentDayIndex);
      monthController.jumpToItem(currentMonthIndex);
      yearController.jumpToItem(currentYearIndex);
    }
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////

  /// weight view
  /////////////////
   double selectedWeight = 70.0;
  int currentWeightIndex = 0;

   String selectedWeightUnit = 'kg';

   late FixedExtentScrollController weightController;

   final List<double> weights = List.generate(200, (index) => 20.0 + index);

   void initWeightPicker({double? initialWeight, String initialUnit = 'kg'}) {
    selectedWeight = initialWeight ?? 70.0;
    selectedWeightUnit = initialUnit;

    currentWeightIndex = weights.indexOf(selectedWeight.roundToDouble());
    if (currentWeightIndex == -1) {
      selectedWeight = weights[0];
      currentWeightIndex = 0;
    }

    weightController = FixedExtentScrollController(
      initialItem: currentWeightIndex.clamp(0, weights.length - 1),
    );
  }

  /// تغيير الوزن
  void onWeightChanged(int index) {
    selectedWeight = weights[index];
    currentWeightIndex = index;
    emit(OnboardingProfileSetupSuccessState());
  }

  /// تغيير الوحدة
  void onWeightUnitChanged(String unit) {
    selectedWeightUnit = unit;
    emit(OnboardingProfileSetupSuccessState());
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
