import '../../../onboarding_profile_setup/data/models/update_profile_response_model .dart';
import '../../presentation/views/profile/personal_info/models/user_data_model.dart';

abstract class PersonalInfoState {}

class PersonalInfoInitialState extends PersonalInfoState {}

class PersonalInfoImagePickedState extends PersonalInfoState {}

class PersonalInfoFirstNameChangedState extends PersonalInfoState {}

class PersonalInfoLastNameChangedState extends PersonalInfoState {}

class PersonalInfoEmailChangedState extends PersonalInfoState {}

class PersonalInfoPhoneChangedState extends PersonalInfoState {}

class PersonalInfoGenderChangedState extends PersonalInfoState {}

class PersonalInfoAgeChangedState extends PersonalInfoState {}

class PersonalInfoHeightChangedState extends PersonalInfoState {}

class PersonalInfoWeightChangedState extends PersonalInfoState {}

class PersonalInfoHealthGoalChangedState extends PersonalInfoState {}

class PersonalInfoAddressChangedState extends PersonalInfoState {}

class PersonalInfoDateChangedState extends PersonalInfoState {}

class PersonalInfoLoadingState extends PersonalInfoState {}

class PersonalInfoSuccessState extends PersonalInfoState {}

class PersonalInfoErrorState extends PersonalInfoState {}

class PersonalInfoTempGenderChangedState extends PersonalInfoState {}

class PersonalInfoImageRemovedState extends PersonalInfoState {}

class PersonalInfoCountryCodeChangedState extends PersonalInfoState {}

class UpdateProfileLoadingState extends PersonalInfoState {}

class PersonalInfoDateSelectedState extends PersonalInfoState {}

class PersonalInfoUpdateGenderState extends PersonalInfoState {}

class PersonalInfoUpdateHealthGoalState extends PersonalInfoState {}

//update
class UpdateProfileErrorState extends PersonalInfoState {
  String error;

  UpdateProfileErrorState(this.error);
}

class UpdateProfileSuccessState extends PersonalInfoState {
  UserProfileResult userProfileResult;

  UpdateProfileSuccessState(this.userProfileResult);
}

//update

class PersonalInfoLoading extends PersonalInfoState {}

class PersonalInfoLoaded extends PersonalInfoState {
  final UserData userData;

  PersonalInfoLoaded(this.userData);
}

class PersonalInfoUpdating extends PersonalInfoState {}

class PersonalInfoUpdateSuccess extends PersonalInfoState {}

class PersonalInfoError extends PersonalInfoState {
  final String message;

  PersonalInfoError(this.message);
}

//delete
class DeleteAccountSuccessState extends PersonalInfoState {
  final String message;

  DeleteAccountSuccessState(this.message);
}

class DeleteAccountErrorState extends PersonalInfoState {
  final String error;

  DeleteAccountErrorState(this.error);
}

class DeleteAccountLoadingState extends PersonalInfoState {}
