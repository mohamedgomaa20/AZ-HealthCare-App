import 'package:az_health_care/core/widgets/auth_nested_scroll_view.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/sign_up_footer.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/signup_fields.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/terms_and_conditions_dialog.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/onboarding_profile_setup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/services/show_toast.dart';
import '../../../../../home/manager/personal_info_cubit/personal_info_cubit.dart';
import '../../../../manger/register_cubit/register_cubit.dart';
import '../../../../manger/register_cubit/register_states.dart';
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
    return BlocConsumer<RegisterCubit, RegisterStates>(
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
          context.read<PersonalInfoCubit>().fetchUserData();

          ToastHelper.showToast2(
            bottomOffset: 50,
            context: context,
            msg: "Registration successful!",
            state: ToastStates.SUCCESS,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OnboardingProfileSetupView(),
            ),
          );
        }
        if (state is RegisterErrorState) {
          ToastHelper.showToast2(
            bottomOffset: 120,
            context: context,
            msg: state.error,
            state: ToastStates.ERROR,
          );
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
    );
  }
}
