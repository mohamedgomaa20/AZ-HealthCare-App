import 'package:az_health_care/core/network/end_points.dart';
import 'package:az_health_care/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/services/cache_helper.dart';
import '../../data/models/EmergencyContactsResponse.dart';
import 'emergency_contacts_states.dart';

class EmergencyContactsCubit extends Cubit<EmergencyContactsStates> {
  EmergencyContactsCubit() : super(EmergencyContactsInitial());

  static EmergencyContactsCubit get(context) => BlocProvider.of(context);

  String? contactName;
  String? contactPhoneNumber;
  String? contactRelationship;
  String? contactEmail;
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController contactPhoneNumberController =
      TextEditingController();
  final TextEditingController contactRelationshipController =
      TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();

  void updateContactName(String value) {
    contactName = value.trim();
    emit(EmergencyContactsChangedState());
  }

  void updateContactPhoneNumber(String value) {
    contactPhoneNumber = value.trim();

    emit(EmergencyContactsChangedState());
  }

  void updateContactRelationship(String value) {
    contactRelationship = value.trim();
    emit(EmergencyContactsChangedState());
  }

  void updateContactEmail(String value) {
    contactEmail = value.trim();
    emit(EmergencyContactsChangedState());
  }

  void addEmergencyContact() {
    emit(EmergencyAddContactsLoadingState());

    var id = CacheHelper.getData(key: 'id');
    print(id);
    if (contactEmail == null || contactEmail!.isEmpty) {
      emit(EmergencyAddContactsErrorState("Email is required"));
      return;
    }

    if (contactPhoneNumber == null || contactPhoneNumber!.isEmpty) {
      emit(EmergencyAddContactsErrorState("Phone number is required"));
      return;
    }
    final phoneRegExp = RegExp(r'^[0-9]+$');
    if (!phoneRegExp.hasMatch(contactPhoneNumber!)) {
      emit(EmergencyAddContactsErrorState("Phone number format is invalid"));
      return;
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(contactEmail!)) {
      emit(EmergencyAddContactsErrorState("Email format is invalid"));
      return;
    }
    if (id == null) {
      emit(EmergencyAddContactsErrorState('User ID not found. Please login.'));
      return;
    }

    DioHelper.postData(
          url: ADD_EMERGENCY_CONTACT,
          query: {'userId': id},
          data: {
            "name": contactName,
            "phoneNumber": contactPhoneNumber,
            "email": contactEmail,
            "userId": id,
            "relationship": contactRelationship,
          },
        )
        .then((value) {
          if (value.statusCode == 200 || value.statusCode == 201) {
            print(value.data);
            print(value.statusCode);
            print(value.statusMessage);
            emit(EmergencyAddContactsSuccessState());
          } else {
            print(value.statusMessage);
            emit(EmergencyAddContactsErrorState("${value.statusMessage}"));
          }
        })
        .catchError((error) {
          print(error.toString());
          emit(EmergencyAddContactsErrorState(error.toString()));
        });
  }

  /////////////////////////////////////////////////

  List<EmergencyContactModel>? contactList;

  void getEmergencyContacts() {
    print("==================================");
    if (contactList != null) {
      print(contactList);
      print(contactList?.length);
      print("==================================");
    }

    emit(EmergencyGetContactsLoadingState());

    var userId = CacheHelper.getData(key: 'id');
    print("===============================");
    print("User ID: $userId");

    print("===============================");
    if (userId == null || userId.isEmpty) {
      emit(EmergencyGetContactsErrorState("User ID not found."));
      return;
    }

    DioHelper.getData(
          url:
              "http://healthmonitoring.runasp.net/api/EmergencyContact/$userId/emergency-contacts",
        )
        .then((response) {
          final data = EmergencyContactsResponse.fromJson(response.data);

          if (data.isSuccess == true && data.result != null) {
            contactList = data.result!.emergencyContacts ?? [];
            print('===========success===============');
            print(contactList);
            emit(EmergencyGetContactsSuccessState(contactList));
          } else {
            emit(EmergencyGetContactsErrorState("Failed to load contacts."));
          }
        })
        .catchError((error) {
          print('===========error===============');
          print(error.toString());
          print("==================================");
          emit(EmergencyGetContactsErrorState("Error: ${error.toString()}"));
        });
  }

  //delete contact
  void deleteEmergencyContact(int contactId) {
    emit(EmergencyDeleteContactLoadingState());
    // /api/EmergencyContact/disconnect/6120fa63-30%2073-4f54-a204-47c5c4bdcc00/16
    var userId = CacheHelper.getData(key: 'id');
    DioHelper.deleteData(
          url: '/api/EmergencyContact/disconnect/$userId/$contactId',
        )
        .then((value) {
          contactList?.removeWhere((contact) => contact.contactId == contactId);
          print('===========success===============');
          print("contact deleted:$contactId");
          emit(EmergencyDeleteContactSuccessState());
          print("==================================");
          getEmergencyContacts();
        })
        .catchError((error) {
          print('===========error===============');
          print(error.toString());
          print("==================================");
          emit(EmergencyDeleteContactErrorState(error.toString()));
        });
  }
}
