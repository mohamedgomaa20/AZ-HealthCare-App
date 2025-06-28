abstract class OnboardingProfileSetupStates {}

class OnboardingProfileSetupInitialState extends OnboardingProfileSetupStates {}

class OnboardingProfileSetupLoadingState extends OnboardingProfileSetupStates {}

class OnboardingProfileSetupSuccessState extends OnboardingProfileSetupStates {}
class OnboardingProfileSetupPageChangedState extends OnboardingProfileSetupStates {}

class OnboardingProfileSetupErrorState extends OnboardingProfileSetupStates {
  final String error;

  OnboardingProfileSetupErrorState(this.error);
}
