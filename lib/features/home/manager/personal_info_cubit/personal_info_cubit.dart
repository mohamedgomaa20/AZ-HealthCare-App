import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants.dart';
import '../../../../../../core/network/end_points.dart';
import '../../../../../../core/services/cache_helper.dart';
import '../../../../../../core/utils/gender_enum.dart';
import '../../../../../../shared/network/remote/dio_helper.dart';
import '../../../onboarding_profile_setup/data/models/update_profile_response_model .dart';
import '../../presentation/views/profile/personal_info/models/user_data_model.dart';
import 'personal_info_state.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit() : super(PersonalInfoInitialState());

  static PersonalInfoCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // Gender selectedGender = Gender.male;
  //
  // Gender tempSelectedGender = Gender.male;
  String? tempSelectedGender;
  String? selectedGender;
  String? selectedHealthGoal;

  Gender genderFromLabel(String label) {
    switch (label) {
      case 'Male':
        return Gender.male;
      case 'Female':
        return Gender.female;
      case 'Prefer not to say':
        return Gender.preferNotToSay;
      default:
        return Gender.male;
    }
  }

  String? firstName;

  String? lastName;

  String? phoneNumber;

  String? address;

  String? gender;
  String? healthGoal;
  String? age;

  int? height;

  double? weight;

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  void updateGender(String genderValue) {
    gender = genderValue;
    emit(PersonalInfoUpdateGenderState());
  }

  void updateHealthGoal(String goal) {
    healthGoal = goal;
    emit(PersonalInfoUpdateHealthGoalState());
  }

  void setTempGender(Gender gender) {
    selectedGender = gender.label;
    emit(PersonalInfoTempGenderChangedState());
  }

  void confirmTempGender() {
    selectedGender = tempSelectedGender;
    emit(PersonalInfoGenderChangedState());
  }

  void changeGender(Gender gender) {
    selectedGender = gender.label;
    emit(PersonalInfoGenderChangedState());
  }

  void pickImage(File file) {
    selectedImage = file;
    emit(PersonalInfoImagePickedState());
  }

  void updateFirstName(String value) {
    firstName = value.trim();
    emit(PersonalInfoPhoneChangedState());
  }

  void updateLastName(String value) {
    lastName = value.trim();

    emit(PersonalInfoPhoneChangedState());
  }

  void updateAddress(String value) {
    address = value.trim();
    emit(PersonalInfoAddressChangedState());
  }

  void updatePhoneNumber(String value) {
    phoneNumber = value.trim();
    emit(PersonalInfoPhoneChangedState());
  }

  void updateAge(String value) {
    age = value.trim();
    emit(PersonalInfoAgeChangedState());
  }

  void updateWeight(String value) {
    weight = double.parse(value.trim());
    emit(PersonalInfoWeightChangedState());
  }

  void updateHeight(String value) {
    height = int.parse(value.trim());
    emit(PersonalInfoHeightChangedState());
  }

  late UpdateProfileResponse updatedProfileResponse;

  void updateUserProfile() {
    emit(UpdateProfileLoadingState());

    var id = CacheHelper.getData(key: "id");
    int? ageValue;
    if (age != null && age.toString().isNotEmpty) {
      ageValue = int.tryParse(age.toString());
    }
    print("=================================");
    print("id: $id");
    print("=================================");
    DioHelper.putData(
          url: "$UPDATE_PROFILE$id",
          data: {
            "id": id,
            "firstName": firstName,
            "lastName": lastName,
            "name": "$firstName $lastName",
            "phoneNumber": phoneNumber,
            "address": address ?? "",
            "age": ageValue,
            "dateOfBirth": "2025-07-06T08:45:59.334Z",
            "gender": gender,
            "weightKg": weight,
            "height": height,
            "healthGoals": healthGoal,
            "updatedAt": "2025-07-06T08:45:59.334Z",
          },
        )
        .then((value) {
          print("============controller=================");
          print("firstName $firstName");
          print("lastName $lastName");
          print("phoneNumber $phoneNumber");
          print("address $address ");
          print("age $age");
          print("weight $weight  ???");
          print("height $height  ???");
          print("gender $gender   ???");
          print("healthGoal $healthGoal ???");
          print("healthGoal $healthGoal ???");
          print("================= success ===================");
          print(value.statusCode);
          print(value.statusMessage);
          print(value.data);
          // updatedProfileResponse = UpdateProfileResponse.fromJson(value.data);
          if (age == null) {
            emit(PersonalInfoError("Please enter your age"));
          }
          print(
            "===================data in personal info==========================",
          );
          updatedProfileResponse = UpdateProfileResponse.fromJson(value.data);
          if (value.statusCode == 200 ||
              value.statusCode == 204 &&
                  updatedProfileResponse.result != null) {
            userProfileResult = updatedProfileResponse.result!;
            print(userProfileResult);
            print(userProfileResult?.id ?? "");
            print(userProfileResult?.firstName ?? "");
            print(userProfileResult?.lastName ?? "");
            print("address");
            print(userProfileResult?.address ?? "");
            print("============");
            print(userProfileResult?.age ?? 0);
            print("height : ${userProfileResult?.height ?? 0}");
            print(userProfileResult?.weightKg ?? 0.0);
            print(userProfileResult?.phoneNumber ?? "");
            print("============");
            print(userProfileResult?.gender ?? "");
            print(userProfileResult?.healthGoals ?? "");
            print("============");
            emit(UpdateProfileSuccessState(userProfileResult!));
            print("====================end of data=========================");
          } else {
            print("❌ Failed with status: ${value.statusCode}");
            emit(UpdateProfileErrorState("Server error: ${value.statusCode}"));
          }
        })
        .catchError((error) {
          print("================= error ===================");
          emit(UpdateProfileErrorState(error.toString()));

          print(error.toString());
          print("=============================================");
        });
  }

  ////==================================================================
  UserData? userData;

  Future<void> fetchUserData() async {
    emit(PersonalInfoLoading());

    String userId = CacheHelper.getData(key: 'id');
    print("=================================");
    print("userId: $userId");
    print("=================================");
    emit(PersonalInfoLoading());
    print("=================================");
    print("intro userId: $userId");
    print("Welcome to fetchUserData Mohamed Gomaa");

    try {
      final response = await DioHelper.getData(
        url: '$FETCH_USER__DATA_BY_ID$userId',
      );
      print(response.data);
      if (response.statusCode == 200 &&
          response.data['isSuccess'] &&
          response.data != null) {
        print("============== in if===================");
        userData = UserData.fromJson(response.data['result']);

        _fillControllersWithData(userData!);
        print("=======================fetch ========================");
        print("================response===================");
        print(response.statusCode);
        print(response.data['result']);
        print(response.data['result']['id']);
        print(response.data['result']['userName']);
        print(response.data['result']['email']);
        print(response.data['result']['role']);

        print(response.data['result']['name']);
        print(response.data['result']['firstName']);
        print(response.data['result']['lastName']);
        print(response.data['result']['phoneNumber']);

        print(response.data['result']['address']);
        print(response.data['result']['dateOfBirth']);
        print(response.data['result']['gender']);
        print(response.data['result']['age']);
        print(response.data['result']['height']);
        print(response.data['result']['weightKg']);
        print(response.data['result']['healthGoals']);
        print(response.data['result']['createdDate']);
        print(response.data['result']['updatedAt']);
        print("===========================================");
        print(userData?.id);
        print(userData?.userName);
        print(userData?.email);
        print(userData?.role);

        print(userData?.firstName);
        print(userData?.lastName);
        print(userData?.phoneNumber);

        print(userData?.gender);
        print('age ${userData?.age}');
        print(userData?.weightKg);
        print(userData?.height);
        print(userData?.address);
        print(userData?.role);
        print(userData?.dateOfBirth);
        print(userData?.healthGoals);
        print(userData?.createdDate);
        print(userData?.updatedAt);
        print("==========================================");
        emit(PersonalInfoLoaded(userData!));
      } else {
        print("❌ Failed with status: ${response.statusCode}");
        print("❌ Failed with status: ${response.statusMessage}");
        emit(PersonalInfoError('Failed to fetch user data'));
      }
    } catch (e) {
      print("===================================");
      print("Error fetching user data: $e");
      print("===================================");
      emit(PersonalInfoError('Error: ${e.toString()}'));
    }
  }

  void _fillControllersWithData(UserData userData) {
    firstNameController.text = userData.firstName ?? "";
    firstName = userData.firstName ?? "";

    lastNameController.text = userData.lastName ?? "";
    lastName = userData.lastName ?? "";

    phoneNumberController.text = userData.phoneNumber ?? "";
    phoneNumber = userData.phoneNumber ?? "";

    ageController.text = userData.age?.toString() ?? "";
    age = age ?? "";

    heightController.text = userData.height?.toString() ?? "";
    height = userData.height ?? 0;

    weightController.text = userData.weightKg?.toString() ?? "";
    weight = userData.weightKg ?? 0;

    addressController.text = userData.address?.toString() ?? "";
    address = userData.address ?? "";

    gender = userData.gender ?? "";
    healthGoal = userData.healthGoals ?? "";
  }

  void deleteAccount() {
    var id = CacheHelper.getData(key: 'id');

    if (id == null) {
      emit(DeleteAccountErrorState("User not found. Please login again."));
      return;
    }

    emit(DeleteAccountLoadingState());

    DioHelper.deleteData(url: "$DELETE_ACCOUNT$id")
        .then((value) {
          print("===================================");
          print("Delete Account Response: ${value.data}");
          print("===================================");

          final responseData = value.data;
          final statusCode = responseData['statusCode'];
          final isSuccess = responseData['isSuccess'];

          if (statusCode == 200 && isSuccess == true) {
            final message = responseData['result'];

            CacheHelper.removeData(key: 'id');
            CacheHelper.removeData(key: 'token');

            emit(DeleteAccountSuccessState(message));
            print("Account deleted successfully: $message");
          } else {
            String errorMessage = "Failed to delete account";

            final errors = responseData['errors'];
            if (errors != null) {
              if (errors is Map<String, dynamic>) {
                if (errors.isNotEmpty) {
                  final firstKey = errors.keys.first;
                  final firstValue = errors[firstKey];
                  if (firstValue is List && firstValue.isNotEmpty) {
                    errorMessage = firstValue.first.toString();
                  } else if (firstValue is String) {
                    errorMessage = firstValue;
                  }
                }
              } else if (errors is List && errors.isNotEmpty) {
                errorMessage = errors.first.toString();
              }
            }

            emit(DeleteAccountErrorState(errorMessage));
            print("Delete account failed: $errorMessage");
          }
        })
        .catchError((error) {
          print("===================================");
          print("Error Delete Account: $error");
          print("===================================");
          emit(
            DeleteAccountErrorState("Something went wrong. Please try again."),
          );
        });
  }

  // void deleteAccount() {
  //   var id = CacheHelper.getData(key: 'id');
  //
  //   if (id == null) {
  //     emit(DeleteAccountErrorState("User not found. Please login again."));
  //     return;
  //   }
  //
  //   emit(DeleteAccountLoadingState());
  //
  //   DioHelper.deleteData(url: "$DELETE_ACCOUNT$id")
  //       .then((value) {
  //     print("===================================");
  //     print("Delete Account Response: ${value.data}");
  //     print("===================================");
  //
  //     final responseData = value.data;
  //     final statusCode = responseData['statusCode'];
  //     final isSuccess = responseData['isSuccess'];
  //
  //     if (statusCode == 200 && isSuccess == true) {
  //       final message = responseData['result'];
  //
  //       CacheHelper.removeData(key: 'id');
  //       CacheHelper.removeData(key: 'token');
  //
  //       emit(DeleteAccountSuccessState(message));
  //       print("Account deleted successfully: $message");
  //     } else {
  //       final errors = responseData['errors'] as List?;
  //       String errorMessage = "Failed to delete account";
  //
  //       if (errors != null && errors.isNotEmpty) {
  //         errorMessage = errors.first.toString();
  //       }
  //       emit(DeleteAccountErrorState(errorMessage));
  //       print("Delete account failed: $errorMessage");
  //     }
  //   })
  //       .catchError((error) {
  //     print("===================================");
  //     print("Error Delete Account: $error");
  //     print("===================================");
  //     emit(DeleteAccountErrorState("Something went wrong. Please try again."));
  //   });
  // }

  // Future<void> updateUserProfile2() async {
  //   String userId = CacheHelper.getData(key: 'id');
  //
  //   if (!formKey.currentState!.validate()) return;
  //
  //   emit(PersonalInfoUpdating());
  //   if (age == null) {
  //     emit(PersonalInfoError("Please enter your age"));
  //   }
  //   try {
  //     final updateData = {
  //       "id": userId,
  //       'firstName': firstName,
  //       'lastName': firstName,
  //       "name": "string",
  //       'phoneNumber': phoneNumber,
  //       "address": address,
  //       'gender': gender,
  //       "dateOfBirth": "2025-07-06T08:45:59.334Z",
  //       'age': age ?? 0,
  //       'weightKg': weight,
  //       'height': height,
  //       'healthGoals': healthGoal,
  //       "updatedAt": "2025-07-06T11:57:04.266Z",
  //     };
  //
  //     final response = await DioHelper.putData(
  //       url: 'http://healthmonitoring.runasp.net/api/Users/Update$userId',
  //       data: updateData,
  //     );
  //
  //     if (response.statusCode == 204 ||
  //         (response.data != null && response.data['isSuccess'])) {
  //       emit(PersonalInfoUpdateSuccess());
  //       // await getUserData();
  //     } else {
  //       emit(PersonalInfoError('Failed to update profile'));
  //     }
  //   } catch (e) {
  //     emit(PersonalInfoError('Error: ${e.toString()}'));
  //   }
  // }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    return super.close();
  }
}

// Future<void> selectDate(BuildContext context) async {
//   DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: DateTime(1995, 12, 27),
//     firstDate: DateTime(1900),
//     lastDate: DateTime.now(),
//     builder: (context, child) {
//       return Theme(
//         data: ThemeData.dark().copyWith(
//           colorScheme: ColorScheme.dark(
//             primary: Colors.blue,
//             surface: Colors.grey[900]!,
//             onSurface: Colors.white,
//           ),
//           dialogTheme: DialogTheme(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//         child: child!,
//       );
//     },
//   );
//
//   if (picked != null) {
//     dobController.text =
//         '${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}-${picked.year}';
//     emit(PersonalInfoDateChangedState());
//   }
// }

// void submitProfile(BuildContext context) {
//   if (formKey.currentState!.validate()) {
//     emit(PersonalInfoLoadingState());
//
//     // You can handle actual update manager here then emit success
//     emit(PersonalInfoSuccessState());
//   }
// }

/*

  String selectedCountryCode = '+1';

  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  final List<Map<String, String>> countryCodes = [
    {'code': '+1', 'flag': '🇺🇸', 'country': 'US'},
    {'code': '+20', 'flag': '🇪🇬', 'country': 'EG'},
    {'code': '+44', 'flag': '🇬🇧', 'country': 'GB'},
    {'code': '+49', 'flag': '🇩🇪', 'country': 'DE'},
    {'code': '+33', 'flag': '🇫🇷', 'country': 'FR'},
  ];

  Future<void> pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        emit(PersonalInfoImagePickedState());
      }
    } catch (e) {
      emit(PersonalInfoErrorState());
    }
  }
 */

//
// void changeLastName(String name) {
//   lastName = name;
//   emit(PersonalInfoLastNameChangedState());
// }
//
// void changeFirstName(String name) {
//   firstName = name;
//   emit(PersonalInfoFirstNameChangedState());
// }

// void changeAddress(String value) {
//   address = value;
//   emit(PersonalInfoAddressChangedState();
//   }

// void changeCountryCode(String code) {
//   selectedCountryCode = code;
//   emit(PersonalInfoCountryCodeChangedState());
// }

/*
 Future<void> pickImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        emit(PersonalInfoImagePickedState());
      }
    } catch (e) {
      emit(PersonalInfoErrorState());
    }
  }

  void removeImage() {
    selectedImage = null;
    emit(PersonalInfoImageRemovedState());
  }
 */
