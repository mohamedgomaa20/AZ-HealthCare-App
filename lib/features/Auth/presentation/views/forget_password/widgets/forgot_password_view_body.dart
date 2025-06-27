import 'package:az_health_care/core/services/show_toast.dart';
import 'package:az_health_care/features/Auth/presentation/views/forget_password/widgets/forgot_password_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/widgets/auth_nested_scroll_view.dart';
import '../../../../../../core/utils/app_text_styles.dart';
import '../forget_password_cubit/forget_password_cubit.dart';
import '../forget_password_cubit/forgot_password_states.dart';
import 'forgot_password_form_field.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  ForgotPasswordViewBody({super.key});

  final formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccessState) {
            ToastHelper.showToast(
              msg: "Reset link sent to ${emailController.text}",
              state: ToastStates.SUCCESS,
            );
            Navigator.pop(context);
          } else if (state is ForgotPasswordErrorState) {
            ToastHelper.showToast(msg: state.error, state: ToastStates.ERROR);
          }
        },

        builder: (context, state) {
          var cubit = ForgotPasswordCubit.get(context);
          return AuthNestedScrollView(
            appBarTitle: "Forgot Password",
            descriptionText:
                "Forgot your password? No problem! Just enter your registered email and we’ll send you a password reset link.",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text("Email", style: AppTextStyles.semiBold16),
                const SizedBox(height: 5),
                ForgotPasswordFormField(
                  controller: emailController,
                  formKey: formKey,
                ),
                const SizedBox(height: 20),
                ForgotPasswordFooter(
                  formKey: formKey,
                  emailController: emailController,
                  condition: state is! ForgotPasswordLoadingState,
                  onPressed: (email) => cubit.sendResetEmail(email),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
