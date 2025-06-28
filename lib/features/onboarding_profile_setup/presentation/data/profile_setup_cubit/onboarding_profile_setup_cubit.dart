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

  /// ================= birthday View Logic =================
  String? name;

  void updateName(String newName) {
    name = newName;
    emit(OnboardingProfileSetupSuccessState());
  }

  /// ================= gender View Logic =================
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
  /// ================= birthday View Logic =================
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

  /// ================= Weight View Logic =================

  double selectedWeight = 70.0;

  int currentWeightIndex = 0;

  String selectedWeightUnit = 'kg';

  FixedExtentScrollController? weightController;

  final List<double> weights = List.generate(200, (index) => 20.0 + index);

  bool isWeightPickerInitialized = false;

  void initWeightPicker({double? initialWeight, String initialUnit = 'kg'}) {
    if (isWeightPickerInitialized) return;

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

    isWeightPickerInitialized = true;
  }

  void onWeightChanged(int index) {
    selectedWeight = weights[index];
    currentWeightIndex = index;
    emit(OnboardingProfileSetupSuccessState());
  }

  double get convertedWeightInKg =>
      selectedWeightUnit == 'lb' ? selectedWeight * 0.453592 : selectedWeight;

  void onWeightUnitChanged(String unit) {
    if (unit == selectedWeightUnit) return;
    selectedWeightUnit = unit;
    emit(OnboardingProfileSetupSuccessState());
  }

  /////////////////////////////////////////////////////

  // ================= Height View Logic =================

  double selectedHeight = 170.0;
  int currentHeightIndex = 0;
  String selectedHeightUnit = 'cm';
  FixedExtentScrollController? heightController;
  final List<double> heights = List.generate(
    151,
    (index) => 100.0 + index,
  ); // 100 to 250 cm
  bool isHeightPickerInitialized = false;

  void initHeightPicker({double? initialHeight, String initialUnit = 'cm'}) {
    if (isHeightPickerInitialized) return;

    selectedHeight = initialHeight ?? 170.0;
    selectedHeightUnit = initialUnit;

    currentHeightIndex = heights.indexOf(selectedHeight.roundToDouble());
    if (currentHeightIndex == -1) {
      selectedHeight = heights[0];
      currentHeightIndex = 0;
    }

    heightController = FixedExtentScrollController(
      initialItem: currentHeightIndex.clamp(0, heights.length - 1),
    );

    isHeightPickerInitialized = true;
  }

  void onHeightChanged(int index) {
    selectedHeight = heights[index];
    currentHeightIndex = index;
    emit(OnboardingProfileSetupSuccessState());
  }

  void onHeightUnitChanged(String unit) {
    if (unit == selectedHeightUnit) return;
    selectedHeightUnit = unit;
    emit(OnboardingProfileSetupSuccessState());
  }

  String convertCmToFeetAndInches(double cm) {
    final totalInches = cm / 2.54;
    final feet = (totalInches / 12).floor();
    final inches = (totalInches % 12).round();
    return "$feet'$inches\"";
  }

  /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////

  /// ================= Reminder View Logic =================

  TimeOfDay selectedReminderTime = TimeOfDay.now();
  String selectedPeriod = 'AM'; // AM or PM

  int selectedHour = 9;
  int selectedMinute = 0;

  int currentHourIndex = 8; // 9 AM
  int currentMinuteIndex = 0;

  FixedExtentScrollController? hourController;
  FixedExtentScrollController? minuteController;

  final List<String> hours = List.generate(
    12,
    (i) => (i + 1).toString().padLeft(2, '0'),
  ); // 01-12
  final List<String> minutes = List.generate(
    60,
    (i) => i.toString().padLeft(2, '0'),
  ); // 00-59

  bool isReminderInitialized = false;

  void initReminderPicker({TimeOfDay? initialTime}) {
    if (isReminderInitialized) return;

    final time = initialTime ?? TimeOfDay.now();

    selectedHour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    selectedMinute = time.minute;
    selectedPeriod = time.period == DayPeriod.am ? 'AM' : 'PM';

    currentHourIndex = hours
        .indexOf(selectedHour.toString().padLeft(2, '0'))
        .clamp(0, hours.length - 1);
    currentMinuteIndex = minutes
        .indexOf(selectedMinute.toString().padLeft(2, '0'))
        .clamp(0, minutes.length - 1);

    hourController = FixedExtentScrollController(initialItem: currentHourIndex);
    minuteController = FixedExtentScrollController(
      initialItem: currentMinuteIndex,
    );

    isReminderInitialized = true;
  }

  void onHourChanged(int index) {
    selectedHour = int.parse(hours[index]);
    currentHourIndex = index;
    _updateSelectedReminderTime();
  }

  void onMinuteChanged(int index) {
    selectedMinute = int.parse(minutes[index]);
    currentMinuteIndex = index;
    _updateSelectedReminderTime();
  }

  void onAmPmChanged(String period) {
    selectedPeriod = period;
    _updateSelectedReminderTime();
  }

  void _updateSelectedReminderTime() {
    int hour24 = selectedHour;
    if (selectedPeriod == 'PM' && selectedHour != 12) hour24 += 12;
    if (selectedPeriod == 'AM' && selectedHour == 12) hour24 = 0;
    selectedReminderTime = TimeOfDay(hour: hour24, minute: selectedMinute);
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
