import 'package:az_health_care/core/widgets/auth_nested_scroll_view.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/register_cubit/register_states.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/sign_up_footer.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/signup_fields.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/terms_and_conditions_dialog.dart';
import 'package:az_health_care/features/get_start/presentation/views/get_start_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/services/show_toast.dart';
import '../../../../../../core/widgets/custom_password_form_field.dart';
import '../register_cubit/register_cubit.dart';
import 'agree_with_action_text.dart';

class SignUpViewBody extends StatelessWidget {
  SignUpViewBody({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final createPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) async {
          if (state is ShowTermsDialogState) {
            showDialog(
              context: context,
              builder:
                  (_) => TermsAndConditionsDialog(
                    title: "Terms & Conditions",
                    body: termsAndConditions,
                    onCancel: () => Navigator.pop(context),
                    onConfirm: () {
                      RegisterCubit.get(context).acceptTermsAndConditions();
                      Navigator.pop(context);
                    },
                  ),
            );
          }
          if (state is RegisterSuccessState) {
            ToastHelper.showToast(
              msg:
                  "Registration successful! Please check your email to activate your account.",
              // "You're almost there! We've sent a confirmation email — please check your inbox to activate your account."
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
          return AuthNestedScrollView(
            appBarTitle: "Join A2Z Care Today \uD83E\uDE7A",
            descriptionText:
                "Create your account and start monitoring your health",

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SignUpFormFields(
                  formKey: formKey,
                  userNameController: userNameController,
                  emailController: emailController,
                  createPasswordController: createPasswordController,
                  confirmPasswordController: confirmPasswordController,
                ),
                SizedBox(height: 10),
                CustomPasswordFormField(
                  label: "Current Password",
                  hintText: "current password",
                  controller: emailController,
                  isPassword: cubit.isConfirmPassword,
                  suffixIcon: cubit.suffixIconConfirmPassword,
                  onChanged: (value) => cubit.onConfirmPasswordChanged(value),
                  onToggleVisibility: cubit.toggleConfirmPasswordVisibility,
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

                RegisterFooter(
                  isValid: cubit.isFormValid && cubit.isAgreeToTerms,
                  condition: state is! RegisterLoadingState,
                  formKey: formKey,
                  emailController: emailController,
                  userNameController: userNameController,
                  passwordController: createPasswordController,
                  onRegisterPressed: (userName, email, password) {
                    cubit.userRegister(
                      userName: userName,
                      email: email,
                      password: password,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/*
  NestedScrollView(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                "Create your account and start monitoring your health",
                                style: AppTextStyles.medium14,
                              ),
                              const SizedBox(height: 45),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SignUpFormFields(
                                    formKey: formKey,
                                    userNameController: userNameController,
                                    emailController: emailController,
                                    createPasswordController:
                                        createPasswordController,
                                    confirmPasswordController:
                                        confirmPasswordController,
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

                                  RegisterFooter(
                                    isValid:
                                        cubit.isFormValid &&
                                        cubit.isAgreeToTerms,
                                    condition: state is! RegisterLoadingState,
                                    formKey: formKey,
                                    emailController: emailController,
                                    userNameController: userNameController,
                                    passwordController:
                                        createPasswordController,
                                    onRegisterPressed: (
                                      userName,
                                      email,
                                      password,
                                    ) {
                                      cubit.userRegister(
                                        userName: userName,
                                        email: email,
                                        password: password,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
            ),
          );
 */
