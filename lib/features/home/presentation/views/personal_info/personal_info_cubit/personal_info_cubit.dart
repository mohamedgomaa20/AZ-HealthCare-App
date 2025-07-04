import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../onboarding_profile_setup/presentation/views/widgets/gender_view.dart';
import 'personal_info_state.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit() : super(PersonalInfoInitialState());

  static PersonalInfoCubit get(BuildContext context) =>
      BlocProvider.of(context);

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Gender selectedGender = Gender.male;
  Gender tempSelectedGender = Gender.male;

  File? selectedImage;
  String selectedCountryCode = '+1';
  final ImagePicker _picker = ImagePicker();

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
  void setTempGender(Gender gender) {
    tempSelectedGender = gender;
    emit(PersonalInfoTempGenderChangedState());
  }

  void confirmTempGender() {
    selectedGender = tempSelectedGender;
    emit(PersonalInfoGenderChangedState());
  }

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

  void pickDate(picked) {
    if (picked != null) {
      dobController.text = DateFormat('MM-dd-yyyy').format(picked);
      emit(PersonalInfoDateSelectedState());
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995, 12, 27),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.blue,
              surface: Colors.grey[900]!,
              onSurface: Colors.white,
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dobController.text =
          '${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}-${picked.year}';
      emit(PersonalInfoDateChangedState());
    }
  }

  void submitProfile(BuildContext context) {
    if (formKey.currentState!.validate()) {
      emit(PersonalInfoLoadingState());

      // You can handle actual update logic here then emit success
      emit(PersonalInfoSuccessState());
    }
  }

  void updateProfile() {
    emit(PersonalInfoLoadingState());

    Future.delayed(const Duration(seconds: 2), () {
      emit(PersonalInfoSuccessState());
    });
  }

  void changeGender(Gender gender) {
    selectedGender = gender;
    emit(PersonalInfoGenderChangedState());
  }


  void changeCountryCode(String code) {
    selectedCountryCode = code;
    emit(PersonalInfoCountryCodeChangedState());
  }

  void pickImage(File file) {
    selectedImage = file;
    emit(PersonalInfoImagePickedState());
  }

  void changeName(String name) {
    fullNameController.text = name;
    emit(PersonalInfoNameChangedState());
  }

  void changeEmail(String email) {
    emailController.text = email;
    emit(PersonalInfoEmailChangedState());
  }

  void changePhone(String phone) {
    phoneController.text = phone;
    emit(PersonalInfoPhoneChangedState());
  }

  void changeDateOfBirth(String dob) {
    dobController.text = dob;
    emit(PersonalInfoDateChangedState());
  }

  void disposeControllers() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
  }
}
