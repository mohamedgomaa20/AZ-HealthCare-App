import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/services/show_toast.dart';
import 'package:az_health_care/core/widgets/custom_modal_controller.dart';
import 'package:az_health_care/core/widgets/custom_text_form_field.dart';
import 'package:az_health_care/features/upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../../../core/utils/app_colors.dart';
import '../../profile/widgets/build_menu_item.dart';

class PersonalInfoViewBody extends StatelessWidget {
  const PersonalInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return PersonalInfoScreen();
  }
}

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController(text: 'Andrew Ainsley');
  final _emailController = TextEditingController(
    text: 'andrew.ainsley@yourdomain.com',
  );
  final _phoneController = TextEditingController(text: '+1 (646) 555-4099');
  final _dobController = TextEditingController(text: '12-27-1995');

  String _selectedGender = 'Male';
  String _selectedCountryCode = '+1';
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final List<Map<String, String>> _countryCodes = [
    {'code': '+1', 'flag': '🇺🇸', 'country': 'US'},
    {'code': '+20', 'flag': '🇪🇬', 'country': 'EG'},
    {'code': '+44', 'flag': '🇬🇧', 'country': 'GB'},
    {'code': '+49', 'flag': '🇩🇪', 'country': 'DE'},
    {'code': '+33', 'flag': '🇫🇷', 'country': 'FR'},
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: 'Personal Info'),
            SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey.shade800,
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child:
                                    _selectedImage != null
                                        ? Image.file(
                                          _selectedImage!,
                                          fit: BoxFit.cover,
                                        )
                                        : Container(
                                          color: AppColors.blueGrayBackground2,
                                          child: const Icon(
                                            Icons.person,
                                            size: 50,
                                            color: AppColors.applePayColor,
                                          ),
                                        ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _showImagePickerOptions,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF246BFD),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF1A1A1A),
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      _buildLabel('Full Name'),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        hintText: 'Enter your full name',
                        keyboardType: TextInputType.name,
                        controller: _fullNameController,
                        validation: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      _buildLabel('Email'),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        prefixIconData: Icons.email_outlined,
                        validation: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      _buildLabel('Phone Number'),
                      const SizedBox(height: 8),
                      _buildPhoneField(),

                      const SizedBox(height: 24),

                      _buildLabel('Gender'),
                      const SizedBox(height: 8),
                      _buildGenderDropdown(),

                      const SizedBox(height: 20),

                      _buildLabel('Date of Birth'),
                      const SizedBox(height: 8),
                      _buildDateField(),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _updateProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF246BFD),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Update Profile',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),

            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCountryCode,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.grayColor,
                ),
                dropdownColor: AppColors.blueGrayBackground2,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCountryCode = newValue!;
                  });
                },
                items:
                    _countryCodes.map<DropdownMenuItem<String>>((country) {
                      return DropdownMenuItem<String>(
                        value: country['code'],
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              country['flag']!,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              country['code']!,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          Container(width: 1, height: 24, color: Colors.grey.shade700),
          Expanded(
            child: CustomTextFormField(
              hintText: "(646) 555-4099",
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              validation: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedGender,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          dropdownColor: AppColors.blueGrayBackground2,
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              _selectedGender = newValue!;
            });
          },
          items:
              _genderOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.blueGrayBackground2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _dobController.text,
              style: const TextStyle(color: Colors.white),
            ),
            const Icon(Icons.calendar_today, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showImagePickerOptions() {
    showCustomModalBottomSheet(
      context: context,
      title: "Choose Image",
      confirmText: "confirmText",
      isHasButtons: false,
      onCancel: () {},
      onConfirm: () {},
      centerWidget: SafeArea(
        child: Wrap(
          children: [
            BuildMenuItem(
              icon: Icons.photo_library,
              title: 'Choose from Gallery',
              hasArrow: false,
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            BuildMenuItem(
              icon: Icons.camera_alt,
              title: 'Take Photo',
              hasArrow: false,
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),

            if (_selectedImage != null)
              BuildMenuItem(
                icon: Icons.camera_alt,
                title: 'Remove Photo',
                hasArrow: false,
                onTap: () {
                  setState(() {
                    _selectedImage = null;
                  });
                },
              ),
          ],
        ),
      ),
    );

    // showModalBottomSheet(
    //   context: context,
    //   backgroundColor: AppColors.blueGrayBackground2,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    //   ),
    //   builder: (BuildContext context) {
    //     return SafeArea(
    //       child: Wrap(
    //         children: [
    //           ListTile(
    //             leading: const Icon(Icons.photo_library, color: Colors.white),
    //             title: const Text(
    //               'Choose from Gallery',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             onTap: () {
    //               Navigator.pop(context);
    //               _pickImage(ImageSource.gallery);
    //             },
    //           ),
    //           ListTile(
    //             leading: const Icon(Icons.camera_alt, color: Colors.white),
    //             title: const Text(
    //               'Take Photo',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             onTap: () {
    //               Navigator.pop(context);
    //               _pickImage(ImageSource.camera);
    //             },
    //           ),
    //           if (_selectedImage != null)
    //             ListTile(
    //               leading: const Icon(Icons.delete, color: Colors.red),
    //               title: const Text(
    //                 'Remove Photo',
    //                 style: TextStyle(color: Colors.red),
    //               ),
    //               onTap: () {
    //                 Navigator.pop(context);
    //                 setState(() {
    //                   _selectedImage = null;
    //                 });
    //               },
    //             ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995, 12, 27),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF246BFD),
              surface: Color(0xFF262626),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dobController.text =
            '${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}-${picked.year}';
      });
    }
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      ToastHelper.showToast2(
        context: context,
        msg: 'Profile updated successfully!',
        state: ToastStates.SUCCESS,
      );

      print('Full Name: ${_fullNameController.text}');
      print('Email: ${_emailController.text}');
      print('Phone: $_selectedCountryCode ${_phoneController.text}');
      print('Gender: $_selectedGender');
      print('Date of Birth: ${_dobController.text}');
      print('Profile Image: ${_selectedImage?.path ?? 'No image selected'}');
    }
  }
}
