import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/widgets/auth_nested_scroll_view.dart';
import 'package:az_health_care/features/home/presentation/views/home_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_text_styles.dart';
import '../../../../../../core/services/show_toast.dart';
import '../../../../../../core/widgets/custom_sliver_app_bar.dart';
import '../login_cubit/login_cubit.dart';
import '../login_cubit/login_states.dart';
import 'login_footer.dart';
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
          return AuthNestedScrollView(
            appBarTitle: 'Welcome Back! 👋',
            descriptionText: "Log in to continue your health journey",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginFormFields(
                  formKey: formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 10),
                LoginFooter(
                  isValid: isValid,
                  condition: state is! LoginLoadingState,
                  formKey: formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                  onLoginPressed: (email, password) {
                    cubit.userLogin(email: email, password: password);
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
                              const SizedBox(height: 10),
                              LoginFooter(
                                isValid: isValid,
                                condition: state is! LoginLoadingState,
                                formKey: formKey,
                                emailController: emailController,
                                passwordController: passwordController,
                                onLoginPressed: (email, password) {
                                  cubit.userLogin(
                                    email: email,
                                    password: password,
                                  );
                                },
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
