import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:az_health_care/core/widgets/custom_text_form_field.dart';
import 'package:az_health_care/features/Auth/presentation/views/login/widgets/remember_me_widget.dart';
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

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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
            Navigator.pushReplacementNamed(
              context,
              HomeLayout.routeName, // Replace with your home route name
            );
          }
          if (state is LoginErrorState) {
            ToastHelper.showToast(msg: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
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
                          child: Form(
                            key: formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  "Log in to continue your health journey",
                                  style: AppTextStyles.medium14,
                                ),
                                const SizedBox(height: 45),
                                Text("Email", style: AppTextStyles.semiBold16),
                                const SizedBox(height: 5),
                                CustomTextFormField(
                                  hintText: "Email",
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIconData: Icons.email,
                                  validation: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email is required';
                                    }
                                    final emailRegex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                    );
                                    if (!emailRegex.hasMatch(value)) {
                                      return 'Enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Password",
                                  style: AppTextStyles.semiBold16,
                                ),
                                const SizedBox(height: 5),
                                CustomTextFormField(
                                  hintText: "Password",
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  prefixIconData: Icons.lock,
                                  suffixIconData:
                                      cubit.isPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                  suffixOnPressed: () {
                                    cubit.togglePasswordVisibility();
                                  },
                                  isPassword: cubit.isPassword,
                                  validation: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    if (value.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    }

                                    //   final hasUppercase = value.contains(
                                    //     RegExp(r'[A-Z]'),
                                    //   );
                                    //   final hasLowercase = value.contains(
                                    //     RegExp(r'[a-z]'),
                                    //   );
                                    //   final hasDigit = value.contains(
                                    //     RegExp(r'[0-9]'),
                                    //   );
                                    //   final hasSpecialChar = value.contains(
                                    //     RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
                                    //   );
                                    //
                                    //   if (!hasUppercase) {
                                    //     return 'Password must include an uppercase letter';
                                    //   }
                                    //   if (!hasLowercase) {
                                    //     return 'Password must include a lowercase letter';
                                    //   }
                                    //   if (!hasDigit) {
                                    //     return 'Password must include a number';
                                    //   }
                                    //   if (!hasSpecialChar) {
                                    //     return 'Password must include a special character';
                                    //   }
                                    //
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                RememberMeWidget(),
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
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.userLogin(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                          }
                                        },
                                      ),
                                  fallback: (context) => CustomLoadingButton(),
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
        },
      ),
    );
  }
}
