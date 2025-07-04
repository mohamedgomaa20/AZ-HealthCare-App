import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_images.dart';
import '../../../../../../core/widgets/custom_modal_controller.dart';
import '../../profile/widgets/build_menu_item.dart';
import '../personal_info_cubit/personal_info_cubit.dart';
import '../personal_info_cubit/personal_info_state.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PersonalInfoCubit.get(context);
    return Center(
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade800, width: 2),
            ),
            child: BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
              builder: (context, state) {
                final cubit = PersonalInfoCubit.get(context);
                return CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      cubit.selectedImage != null
                          ? FileImage(cubit.selectedImage!)
                          : AssetImage(AppImages.avatarMan) as ImageProvider,
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                showCustomModalBottomSheet(
                  context: context,
                  title: "Choose Image",
                  isHasButtons: false,
                  confirmText: "confirmText",
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
                            cubit.pickImageFromGallery();
                          },
                        ),
                        BuildMenuItem(
                          icon: Icons.camera_alt,
                          title: 'Take Photo',
                          hasArrow: false,
                          onTap: () {
                            Navigator.pop(context);
                            cubit.pickImageFromCamera();
                          },
                        ),
                        if (cubit.selectedImage != null)
                          BuildMenuItem(
                            icon: Icons.delete,
                            leadingIconColor: AppColors.redColor,
                            titleColor: AppColors.redColor,
                            title: 'Remove Photo',
                            hasArrow: false,
                            onTap: () {
                              Navigator.pop(context);
                              cubit.removeImage();
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF246BFD),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF1A1A1A), width: 2),
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
    );
  }
}
