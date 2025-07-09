import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/PersonalOnboardingState.dart';
import '../data/models/personal_onboarding_models.dart';


class PersonalOnboardingCubit extends Cubit<PersonalOnboardingState> {
  PersonalOnboardingCubit()
    : super(PersonalOnboardingState(model: PersonalOnboardingModel()));

  void updateFirstName(String firstName) {
    emit(state.copyWith(model: state.model.copyWith(firstName: firstName)));
  }

  void updateLastName(String lastName) {
    emit(state.copyWith(model: state.model.copyWith(lastName: lastName)));
  }

  void updatePhoneNumber(String phoneNumber) {
    emit(state.copyWith(model: state.model.copyWith(phoneNumber: phoneNumber)));
  }

  void updateAge(int age) {
    emit(state.copyWith(model: state.model.copyWith(age: age)));
    _calculateTargets();
  }

  void updateHeight(int height) {
    emit(state.copyWith(model: state.model.copyWith(height: height)));
    _calculateTargets();
  }

  void updateWeight(double weight) {
    emit(state.copyWith(model: state.model.copyWith(weight: weight)));
    _calculateTargets();
  }

  void updateGender(String gender) {
    emit(state.copyWith(model: state.model.copyWith(gender: gender)));
    _calculateTargets();
  }

  void updateActivityLevel(String activityLevel) {
    emit(
      state.copyWith(model: state.model.copyWith(activityLevel: activityLevel)),
    );
    _calculateTargets();
  }

  void updateHealthGoals(String healthGoals) {
    emit(state.copyWith(model: state.model.copyWith(healthGoals: healthGoals)));
    _calculateTargets();
  }

  void setCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void nextPage() {
    if (state.currentPage < 6) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  void _calculateTargets() {
    if (state.model.age > 0 &&
        state.model.height > 0 &&
        state.model.weight > 0 &&
        state.model.gender.isNotEmpty &&
        state.model.activityLevel.isNotEmpty) {
      int stepsTarget = _calculateStepsTarget();
      int caloriesTarget = _calculateCaloriesTarget();

      emit(
        state.copyWith(
          model: state.model.copyWith(
            calculatedStepsTarget: stepsTarget,
            calculatedCaloriesTarget: caloriesTarget,
          ),
        ),
      );
    }
  }

  int _calculateStepsTarget() {
    switch (state.model.activityLevel) {
      case "Sedentary":
        return 6000;
      case "Lightly Active":
        return 8000;
      case "Moderately Active":
        return 10000;
      case "Very Active":
        return 12000;
      case "Extremely Active":
        return 15000;
      default:
        return 8000;
    }
  }

  int _calculateCaloriesTarget() {
    double bmr;
    if (state.model.gender == "Male") {
      bmr =
          88.362 +
          (13.397 * state.model.weight) +
          (4.799 * state.model.height) -
          (5.677 * state.model.age);
    } else {
      bmr =
          447.593 +
          (9.247 * state.model.weight) +
          (3.098 * state.model.height) -
          (4.330 * state.model.age);
    }

    double activityFactor;
    switch (state.model.activityLevel) {
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

    double tdee = bmr * activityFactor;

    switch (state.model.healthGoals) {
      case "Lose Weight":
        return (tdee - 500).round();
      case "Gain Weight":
        return (tdee + 500).round();
      case "Build Muscle":
        return (tdee + 300).round();
      case "Maintain Current Weight":
        return tdee.round();
      default:
        return tdee.round();
    }
  }

  // Save user profile
  Future<void> saveUserProfile() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Here you would typically save to your backend/database
      // For now, we'll just mark as completed

      emit(
        state.copyWith(
          isLoading: false,
          model: state.model.copyWith(isCompleted: true),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to save profile. Please try again.',
        ),
      );
    }
  }

   void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  bool isPageValid(int page) {
    switch (page) {
      case 0:
        return true;
      case 1:
        return state.model.firstName.isNotEmpty &&
            state.model.lastName.isNotEmpty;
      case 2:
        return state.model.age > 0 &&
            state.model.height > 0 &&
            state.model.weight > 0;
      case 3:
        return state.model.gender.isNotEmpty;
      case 4:
        return state.model.activityLevel.isNotEmpty;
      case 5:
        return state.model.healthGoals.isNotEmpty;
      case 6:
        return true;
      default:
        return false;
    }
  }

  bool get canProceed => isPageValid(state.currentPage);
}
