import 'package:az_health_care/modules/login/widgets/background_container.dart';
import 'package:az_health_care/modules/login/widgets/custom_text_field.dart';
import 'package:az_health_care/modules/register/register_screen.dart';
import 'package:az_health_care/shared/components/components.dart';
import 'package:az_health_care/shared/components/custom_elevated_button.dart';
import 'package:az_health_care/shared/components/top_box.dart';
import 'package:flutter/material.dart';

import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/constants.dart';
import '../on_boarding/on_boarding_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isLoading = false;
  String error = '';

  bool get isEmailValid =>
      RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text);

  bool get isFormValid => isEmailValid && passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      setState(() {
        error = '';
      });
    });

    passwordController.addListener(() {
      setState(() {
        error = '';
      });
    });
  }

  void login() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    // await Future.delayed(const Duration(seconds: 2));

    if (emailController.text != 'm@m.com' ||
        passwordController.text != '123456') {
      setState(() {
        error = "Invalid email or password.";
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BackgroundContainer(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "AZ Healthcare",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40),
                        CustomTextField(
                          label: "Email",
                          hint: "Enter your email",
                          controller: emailController,
                          suffixIcon: Icon(Icons.email),
                          keyboardType: TextInputType.emailAddress,
                          errorText:
                              emailController.text.isNotEmpty && !isEmailValid
                                  ? "Invalid email format"
                                  : null,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: "Password",
                          hint: "Enter your password",
                          controller: passwordController,
                          isPassword: true,
                          isPasswordVisible: isPasswordVisible,
                          togglePassword: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        if (error.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              error,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        const SizedBox(height: 24),
                        CustomElevatedButton(
                          text: "Sign In",
                          isEnabled: isFormValid,
                          onPressed: login,
                        ),
                        const SizedBox(height: 10),
                        if (isLoading) const CircularProgressIndicator(),
                        TextButton(
                          onPressed: () {
                            navigateTo(context, SignUpScreen());
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Don’t have an account? ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                              children: const [
                                TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(),
                        IconButton(
                          onPressed: () {
                            CacheHelper.removeData(key: 'onBoarding').then((
                              value,
                            ) {
                              navigateAndFinish(context, OnBoardingScreen());
                            });
                            token = null;
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          TopBox(text: "Sign In"),
        ],
      ),
    );
  }
}
