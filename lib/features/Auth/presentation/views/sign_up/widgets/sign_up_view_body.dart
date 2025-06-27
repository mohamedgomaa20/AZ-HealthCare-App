import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/register_cubit/register_states.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/switch_auth_text.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/terms_and_conditions_dialog.dart';
import 'package:az_health_care/features/get_start/presentation/views/get_start_view.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/services/show_toast.dart';
import '../../../../../../core/widgets/customLoadingButton.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../core/widgets/or_continue_with.dart';
import '../../../../../get_start/presentation/views/widgets/google_button.dart';
import '../../../../../home/presentation/views/home_layout.dart';
import '../../login/login_view.dart';
import '../../welcome_to_a2z_care/welcome_to_a2z_care_view.dart';
import '../register_cubit/register_cubit.dart';
import 'agree_with_action_text.dart';

class SignUpViewBody extends StatelessWidget {
  SignUpViewBody({super.key});

  String termsText = '';
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final createPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> _showTermsDialog() async {
    if (termsText.isEmpty) {
      termsText = await rootBundle.loadString(
        'assets/texts/terms_conditions.txt',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) async {
          if (state is ShowTermsDialogState) {
            var cubit = RegisterCubit.get(context);
            showDialog(
              context: context,
              builder:
                  (_) => TermsAndConditionsDialog(
                    title: "Terms & Conditions",
                    body: termsAndConditions,
                    onCancel: () => Navigator.pop(context),
                    onConfirm: () {
                      cubit.acceptTermsAndConditions();
                      Navigator.pop(context);
                    },
                  ),
            );
          }
          if (state is RegisterSuccessState) {
            ToastHelper.showToast(
              msg:
                  "Registration successful! Please check your email to activate your account.",
              state: ToastStates.SUCCESS,
            );
            Navigator.pushReplacementNamed(context, GetStartView.routeName);
          }
          if (state is RegisterErrorState) {
            ToastHelper.showToast(msg: state.error, state: ToastStates.ERROR);
          }
        },

        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          final isValid =
              state is RegisterValidationChanged ? state.isValid : false;
          return NestedScrollView(
            headerSliverBuilder:
                (context, innerBoxIsScrolled) => [
                  const CustomSliverAppBar(
                    title: "Join A2Z Care Today \uD83E\uDE7A",
                  ),
                ],
            body: Builder(
              builder:
                  (context) => CustomScrollView(
                    slivers: [
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kHorizontalPadding,
                          ),
                          child: Form(
                            key: formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  "Create your account and start monitoring your health",
                                  style: AppTextStyles.medium14,
                                ),
                                const SizedBox(height: 45),
                                Text(
                                  "UserName",
                                  style: AppTextStyles.semiBold16,
                                ),
                                const SizedBox(height: 5),
                                CustomTextFormField(
                                  hintText: "UserName",
                                  controller: userNameController,
                                  keyboardType: TextInputType.name,
                                  prefixIconData:
                                      CupertinoIcons.profile_circled,
                                  validation: (p0) {
                                    if (p0 == null || p0.isEmpty) {
                                      return 'UserName is required';
                                    }
                                    if (p0.length < 3) {
                                      return 'UserName must be at least 3 characters';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Text("Email", style: AppTextStyles.semiBold16),
                                const SizedBox(height: 5),
                                CustomTextFormField(
                                  hintText: "Email",
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIconData: Icons.email,
                                  onChanged:
                                      (value) => cubit.onEmailChanged(value),
                                  validation: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email is required';
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
                                Text(
                                  "Create Password",
                                  style: AppTextStyles.semiBold16,
                                ),
                                const SizedBox(height: 5),
                                CustomTextFormField(
                                  hintText: "Create Password",
                                  controller: createPasswordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  prefixIconData: Icons.lock,
                                  suffixIconData:
                                      cubit.suffixIconCreatePassword,
                                  suffixOnPressed:
                                      cubit.toggleCreatePasswordVisibility,
                                  isPassword: cubit.isCreatePassword,
                                  onChanged:
                                      (value) =>
                                          cubit.onCreatePasswordChanged(value),
                                  validation: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    if (value.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    }

                                    final hasUppercase = value.contains(
                                      RegExp(r'[A-Z]'),
                                    );
                                    final hasLowercase = value.contains(
                                      RegExp(r'[a-z]'),
                                    );
                                    final hasDigit = value.contains(
                                      RegExp(r'[0-9]'),
                                    );
                                    final hasSpecialChar = value.contains(
                                      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
                                    );

                                    if (!hasUppercase) {
                                      return 'Password must include an uppercase letter';
                                    }
                                    if (!hasLowercase) {
                                      return 'Password must include a lowercase letter';
                                    }
                                    if (!hasDigit) {
                                      return 'Password must include a number';
                                    }
                                    if (!hasSpecialChar) {
                                      return 'Password must include a special character';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Confirm Password",
                                  style: AppTextStyles.semiBold16,
                                ),
                                const SizedBox(height: 5),
                                CustomTextFormField(
                                  hintText: "Confirm Password",
                                  controller: confirmPasswordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  prefixIconData: Icons.lock,
                                  suffixIconData:
                                      cubit.suffixIconCreatePassword,
                                  suffixOnPressed:
                                      cubit.toggleConfirmPasswordVisibility,
                                  isPassword: cubit.isConfirmPassword,
                                  onChanged:
                                      (value) =>
                                          cubit.onConfirmPasswordChanged(value),
                                  validation: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Confirm Password is required';
                                    }
                                    if (value !=
                                        createPasswordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                AgreeWithActionText(
                                  value: cubit.isAgreeToTerms,
                                  onChanged: (val) {
                                    cubit.toggleAgreeToTerms();
                                  },
                                  normalText: "I agree to A2ZCare ",
                                  actionText: "Terms & Conditions",
                                  onTap: () {
                                    cubit.requestShowTermsDialog();
                                  },
                                ),

                                const SizedBox(height: 16),
                                SwitchAuthText(
                                  normalText: "Already have an account? ",
                                  actionText: "Sign in",
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      LoginView.routeName,
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                                const OrContinueWith(),
                                const SizedBox(height: 16),
                                const GoogleButton(),
                                const SizedBox(height: 32),

                                ConditionalBuilder(
                                  condition: state is! RegisterLoadingState,
                                  builder:
                                      (context) => CustomButton(
                                        text: "Sign Up",
                                        onPressed:
                                            cubit.isAgreeToTerms
                                                ? () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    cubit.userRegister(
                                                      userName:
                                                          userNameController
                                                              .text,
                                                      email:
                                                          emailController.text,
                                                      password:
                                                          createPasswordController
                                                              .text,
                                                    );
                                                  }
                                                }
                                                : null,
                                        // () {
                                        //   cubit.userRegister(
                                        //     email: "20monay2@gmail.com",
                                        //     password: "123456",
                                        //     userName: "uNeme3",
                                        //
                                        //   );
                                        // },
                                      ),
                                  fallback:
                                      (context) => const CustomLoadingButton(),
                                ),
                                // CustomButton(
                                //   text: "Sign Up",
                                //   onPressed:
                                //       cubit.isAgreeToTerms
                                //           ? () {
                                //             if (formKey.currentState!
                                //                 .validate()) {
                                //               cubit.userRegister(
                                //                 userName:
                                //                     userNameController.text,
                                //                 email: emailController.text,
                                //                 password:
                                //                     createPasswordController
                                //                         .text,
                                //               );
                                //               Navigator.pushNamed(
                                //                 context,
                                //                 WelcomeToA2zCareView.routeName,
                                //               );
                                //             }
                                //           }
                                //           : null,
                                // ),
                              ],
                            ),
                          ),
                        ),
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
