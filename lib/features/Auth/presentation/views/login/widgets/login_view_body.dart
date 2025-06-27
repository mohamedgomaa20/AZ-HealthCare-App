import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:az_health_care/core/widgets/or_continue_with.dart';
import 'package:az_health_care/features/home/presentation/views/home_layout.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/widgets/customLoadingButton.dart';
import '../../../../../../shared/components/show_tost.dart';
import '../../../../../get_start/presentation/views/widgets/google_button.dart';
import '../../../../../../core/widgets/custom_sliver_app_bar.dart';
import '../../sign_up/sign_up_view.dart';
import '../../sign_up/widgets/switch_auth_text.dart';
import '../login_cubit/login_cubit.dart';
import '../login_cubit/login_states.dart';
import 'login_form_fields.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            ToastHelper.showToast(
              msg: "Login successful",
              state: ToastStates.SUCCESS,
            );
            Navigator.pushReplacementNamed(context, HomeLayout.routeName);
          }
          if (state is LoginErrorState) {
            ToastHelper.showToast(msg: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          final isValid =
              state is LoginValidationChanged ? state.isValid : false;

          final cubit = LoginCubit.get(context);
          return NestedScrollView(
            headerSliverBuilder:
                (context, innerBoxIsScrolled) => [
                  const CustomSliverAppBar(title: 'Welcome Back! 👋'),
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
                                "Log in to continue your health journey",
                                style: AppTextStyles.medium14,
                              ),
                              const SizedBox(height: 45),
                              LoginFormFields(
                                formKey: formKey,
                                emailController: emailController,
                                passwordController: passwordController,
                              ),
                              const SizedBox(height: 16),
                              SwitchAuthText(
                                normalText: "Don't have an account? ",
                                actionText: "Sign Up",
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    SignUpView.routeName,
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              const OrContinueWith(),
                              const SizedBox(height: 16),
                              const GoogleButton(),
                              const SizedBox(height: 32),
                              ConditionalBuilder(
                                condition: state is! LoginLoadingState,
                                builder:
                                    (context) => CustomButton(
                                      text: "Log In",
                                      onPressed:
                                          isValid
                                              ? () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  cubit.userLogin(
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                  );
                                                }
                                              }
                                              : null,
                                    ),
                                fallback:
                                    (context) => const CustomLoadingButton(),
                              ),
                            ],
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
