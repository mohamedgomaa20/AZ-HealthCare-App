import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:az_health_care/core/widgets/custom_text_form_field.dart';
import 'package:az_health_care/features/Auth/presentation/views/login/widgets/social_divider.dart';
import 'package:az_health_care/features/Auth/presentation/views/sign_up/sign_up_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_text_styles.dart';

import '../../../../../../core/widgets/custom_text_button.dart';
import '../../../../../get_start/presentation/views/widgets/google_button.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return
     NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              expandedHeight: 150,
              pinned: true,
              elevation: 4,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: AppColors.backgroundColor,
              surfaceTintColor: Colors.transparent,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final isCollapsed = constraints.biggest.height <= kToolbarHeight + 10;
                  final double expandedTitleLeft = 5;
                  final double collapsedTitleLeft = 60;

                  final double titleLeft = isCollapsed
                      ? collapsedTitleLeft
                      : expandedTitleLeft +
                      (collapsedTitleLeft - expandedTitleLeft) *
                          (1 - (constraints.biggest.height - kToolbarHeight) / (200 - kToolbarHeight));

                  return FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: titleLeft, bottom: 16),
                    title: AnimatedScale(
                      scale: isCollapsed ? 0.8 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: const Text(
                        'Welcome Back! 👋',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
        body: Builder(
          builder: (context) => CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
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
                        controller: TextEditingController(),
                        keyboardType: TextInputType.emailAddress,
                        prefixIconData: Icons.email,
                      ),
                      const SizedBox(height: 30),
                      Text("Password", style: AppTextStyles.semiBold16),
                      const SizedBox(height: 5),
                      CustomTextFormField(
                        hintText: "Password",
                        controller: TextEditingController(),
                        keyboardType: TextInputType.visiblePassword,
                        prefixIconData: Icons.lock,
                        suffixIconData: CupertinoIcons.eye_fill,
                        isPassword: true,
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (val) {},
                                checkColor: Colors.white,
                                activeColor: AppColors.primaryColor,
                              ),
                              const SizedBox(width: 4),
                              Text("Remember me", style: AppTextStyles.semiBold16),
                            ],
                          ),
                          CustomTextButton(text: "Forgot Password?", onPressed: () {}),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppTextStyles.semiBold16,
                          ),
                          CustomTextButton(
                            text: "Sign Up",
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                SignUpView.routeName,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SocialDivider(),
                      const SizedBox(height: 16),
                      const GoogleButton(),
                      const SizedBox(height: 32),
                      CustomButton(buttonText: "Log In", onPressed: () {}),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

    );

  }
}
