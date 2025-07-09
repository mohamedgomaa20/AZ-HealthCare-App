
import '../../data/models/EmergencyContactsResponse.dart';

abstract class EmergencyContactsStates {}

class EmergencyContactsInitial extends EmergencyContactsStates {}

class EmergencyAddContactsLoadingState extends EmergencyContactsStates {}

class EmergencyAddContactsErrorState extends EmergencyContactsStates {
  final String errorMessage;

  EmergencyAddContactsErrorState(this.errorMessage);
}

//add contact
class EmergencyAddContactsSuccessState extends EmergencyContactsStates {}

class EmergencyContactsChangedState extends EmergencyContactsStates {}

class EmergencyGetContactsLoadingState extends EmergencyContactsStates {}

// get contacts
class EmergencyGetContactsErrorState extends EmergencyContactsStates {
  final String errorMessage;

  EmergencyGetContactsErrorState(this.errorMessage);
}

class EmergencyGetContactsSuccessState extends EmergencyContactsStates {
  List<EmergencyContactModel>? contactList;

  EmergencyGetContactsSuccessState(this.contactList);
}

//delete contact
class EmergencyDeleteContactLoadingState extends EmergencyContactsStates {}

class EmergencyDeleteContactSuccessState extends EmergencyContactsStates {}

class EmergencyDeleteContactErrorState extends EmergencyContactsStates {
  final String error;

  EmergencyDeleteContactErrorState(this.error);
}
