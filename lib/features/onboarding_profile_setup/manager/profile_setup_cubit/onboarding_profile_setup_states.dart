import '../../data/models/update_profile_response_model .dart';

abstract class OnboardingProfileSetupStates {}

class OnboardingProfileSetupInitialState extends OnboardingProfileSetupStates {}

class OnboardingProfileSetupLoadingState extends OnboardingProfileSetupStates {}

class OnboardingProfileSetupSuccessState extends OnboardingProfileSetupStates {}

class ReminderPeriodChangedState extends OnboardingProfileSetupStates {}

class OnboardingProfileSetupPageChangedState
    extends OnboardingProfileSetupStates {}

class OnboardingProfileSetupErrorState extends OnboardingProfileSetupStates {
  final String error;

  OnboardingProfileSetupErrorState(this.error);
}

class OnboardingProfileSetupTargetsCalculatedState
    extends OnboardingProfileSetupStates {}

class UpdateProfileLoadingState extends OnboardingProfileSetupStates {}

class UpdateProfileSuccessState extends OnboardingProfileSetupStates {
  final UserProfileResult? userProfileResult;

  UpdateProfileSuccessState(this.userProfileResult);
}

class UpdateProfileErrorState extends OnboardingProfileSetupStates {
  final String error;

  UpdateProfileErrorState(this.error);
}

class PersonalInfoTempGenderChangedState extends OnboardingProfileSetupStates {}

class PersonalInfoGenderChangedState extends OnboardingProfileSetupStates {}

//get profile

class GetProfileDataLoadingState extends OnboardingProfileSetupStates {}

class GetProfileDataSuccessState extends OnboardingProfileSetupStates {}

class GetProfileDataErrorState extends OnboardingProfileSetupStates {
  final String error;

  GetProfileDataErrorState(this.error);
}
class OnboardingProfileSetupClearState extends OnboardingProfileSetupStates {}
