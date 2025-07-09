import 'package:az_health_care/core/services/show_toast.dart';
import 'package:az_health_care/core/widgets/customLoadingButton.dart';
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:az_health_care/features/onboarding_profile_setup/manager/profile_setup_cubit/onboarding_profile_setup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_images.dart';
import '../../../home/manager/personal_info_cubit/personal_info_cubit.dart';
import '../../../home/manager/personal_info_cubit/personal_info_state.dart';
import '../../manager/sensor_upload_cubit/sensor_upload_cubit.dart';
import '../../manager/sensor_upload_cubit/sensor_upload_states.dart';
import '../widgets/HeaderWidget.dart';
import '../widgets/InstructionsWidget.dart';
import '../widgets/WatchIdInputWidget.dart';
import '../widgets/file_selection_widget.dart';

class SensorDataUploadScreen extends StatefulWidget {
  @override
  _SensorDataUploadScreenState createState() => _SensorDataUploadScreenState();
}

class _SensorDataUploadScreenState extends State<SensorDataUploadScreen> {
  final TextEditingController _watchIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SensorUploadCubit, SensorUploadState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          // context.read<PersonalInfoCubit>().fetchUserData();
          ToastHelper.showToast2(
            context: context,
            msg: 'Profile updated successfully',
            state: ToastStates.SUCCESS,
          );
        }
        if (state is SensorUploadSuccessState) {
          // context.read<PersonalInfoCubit>().updateUserProfile();
          ToastHelper.showToast2(
            context: context,
            msg: 'Sensor data uploaded successfully',
            state: ToastStates.SUCCESS,
          );
        } else if (state is SensorUploadErrorState) {
          ToastHelper.showToast2(
            context: context,
            msg: state.message,
            duration: 5,
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<SensorUploadCubit>();

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 15),
              Image.asset(AppImages.smartWatch, height: 130),

              SizedBox(height: 15),
              HeaderWidgetSensor(),

              SizedBox(height: 20),

              WatchIdInputWidget(),

              SizedBox(height: 20),

              FileSelectionWidget(
                onSelectFile: () => cubit.selectJsonFile(),
                selectedFileName: cubit.fileName,
                isFileSelected: cubit.selectedFile != null,
              ),

              SizedBox(height: 20),
              state is SensorUploadLoadingState ||
                      state is UpdateProfileLoadingState ||
                      state is PersonalInfoLoading
                  ? CustomLoadingButton()
                  : CustomButton(
                    text: 'Upload Sensor Data',
                    fontSize: 16,
                    height: 45,
                    onPressed:
                        cubit.selectedFile != null
                            ? () async {
                              await context
                                  .read<OnboardingProfileSetupCubit>()
                                  .updateUserProfile();
                              print("age in sensor data upload view");
                              print(
                                context.read<OnboardingProfileSetupCubit>().age,
                              );
                              print(
                                context
                                    .read<OnboardingProfileSetupCubit>()
                                    .ageController,
                              );
                              await cubit.uploadSensorData();
                              await context
                                  .read<PersonalInfoCubit>()
                                  .fetchUserData();
                            }
                            : null,
                  ),
              SizedBox(height: 15),


              // CustomButton(
              //   text: "update user profile",
              //   onPressed: () {
              //     print("============= updateUserProfile ===================");
              //     context
              //         .read<OnboardingProfileSetupCubit>()
              //         .updateUserProfile();
              //     print("================================");
              //   },
              // ),
              InstructionsWidget(),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _watchIdController.dispose();
    super.dispose();
  }
}
