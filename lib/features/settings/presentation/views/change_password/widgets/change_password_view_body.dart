import 'package:az_health_care/core/services/show_toast.dart';
import 'package:az_health_care/core/widgets/custom_password_form_field.dart';
import 'package:az_health_care/features/Auth/presentation/views/all_set_password/widgets/all_set_password_widget.dart';
import 'package:az_health_care/features/home/presentation/views/home_layout.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/widgets/auth_nested_scroll_view.dart';
import '../../../../../../core/constants.dart';
import '../../../../../../core/widgets/customLoadingButton.dart';
import '../../../../../../core/widgets/custom_button.dart';
 import '../../../../manager/change_password_cubit/change_password_cubit.dart';
import '../../../../manager/change_password_cubit/change_password_states.dart';

class ChangePasswordViewBody extends StatelessWidget {
  ChangePasswordViewBody({super.key});

  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordStates>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            ToastHelper.showToast2(
              context: context,
              msg: "Change password done successfully",
              state: ToastStates.SUCCESS,
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder:
                    (context) => AllSetPasswordWidget(
                      onOkGreatPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeLayout()),
                        );
                      },
                    ),
              ),
            );
            // Navigator.pop(context);
          } else if (state is ChangePasswordErrorState) {
            ToastHelper.showToast2(
              context: context,
              msg: state.error,
              state: ToastStates.ERROR,
            );
          }
        },

        builder: (context, state) {
          var cubit = ChangePasswordCubit.get(context);
          return AuthNestedScrollView(
            appBarTitle: "Change Password",
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  CustomPasswordFormField(
                    label: "Current Password",
                    hintText: "current password",
                    isValidatePassword: false,
                    controller: currentPasswordController,
                    isPassword: cubit.isCurrentPassword,
                    suffixIcon: cubit.suffixIconCurrentPassword,
                    onChanged: (value) => cubit.onCurrentPasswordChanged(value),
                    onToggleVisibility: cubit.toggleCurrentPasswordVisibility,
                  ),

                  const SizedBox(height: 20),
                  CustomPasswordFormField(
                    label: "New Password",
                    hintText: "New password",
                    controller: newPasswordController,
                    isPassword: cubit.isNewPassword,
                    suffixIcon: cubit.suffixIconNewPassword,
                    onChanged: (value) => cubit.onNewPasswordChanged(value),
                    onToggleVisibility: cubit.toggleNewPasswordVisibility,
                  ),
                  const SizedBox(height: 20),
                  CustomPasswordFormField(
                    label: "Confirm Password",
                    hintText: "Confirm password",
                    controller: confirmPasswordController,
                    newPasswordController: newPasswordController,
                    isPassword: cubit.isConfirmPassword,
                    suffixIcon: cubit.suffixIconConfirmPassword,
                    onChanged: (value) => cubit.onConfirmPasswordChanged(value),
                    onToggleVisibility: cubit.toggleConfirmPasswordVisibility,
                  ),
                  SizedBox(height: 32),
                  ConditionalBuilder(
                    condition: state is! ChangePasswordLoadingState,
                    builder:
                        (context) => CustomButton(
                          text: "Save Changes",
                          onPressed:
                              cubit.isFormValid
                                  ? () {
                                    print(
                                      "///////////////////////////////////////////",
                                    );
                                    if (formKey.currentState!.validate()) {
                                      print(
                                        "-----------------formKey.currentState!.validate() -----------------",
                                      );

                                      cubit.changePassword(
                                        email: userModel!.email!,
                                        currentPassword:
                                            currentPasswordController.text,
                                        newPassword: newPasswordController.text,
                                      );
                                    }
                                  }
                                  : null,
                        ),
                    fallback: (context) => const CustomLoadingButton(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
