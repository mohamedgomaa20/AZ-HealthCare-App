import 'package:flutter/material.dart';
import 'package:az_health_care/modules/login/widgets/background_container.dart';
import 'package:az_health_care/shared/components/custom_elevated_button.dart';
import 'package:az_health_care/shared/components/top_box.dart';

import '../login/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;
  String error = '';

  bool get isEmailValid =>
      RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text);

  bool get isPasswordValid => RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#\$%^&*(),.?":{}|<>]).{6,}$',
  ).hasMatch(passwordController.text);

  bool get isFormValid =>
      fullNameController.text.trim().isNotEmpty &&
      isEmailValid &&
      isPasswordValid;

  @override
  void initState() {
    super.initState();

    fullNameController.addListener(_onFormChanged);
    emailController.addListener(_onFormChanged);
    passwordController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {
      error = '';
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUp() {



    setState(() {
      error = '';
    });

    //
    // print("Signed up!");
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
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "AZ Healthcare",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40),
                        CustomTextField(
                          label: "Full Name",
                          hint: "Enter your full name",
                          controller: fullNameController,
                          suffixIcon: const Icon(Icons.person),
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          label: "Email",
                          hint: "Enter your email",
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          suffixIcon: const Icon(Icons.email),
                          errorText: emailController.text.isNotEmpty && !isEmailValid
                              ? "Invalid email format"
                              : null,
                        ),
                        SizedBox(height: 16),
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
                          errorText: passwordController.text.isNotEmpty && !isPasswordValid
                              ? "Password must be at least 6 characters, include uppercase, lowercase, and special character."
                              : null,
                        ),

                        const SizedBox(height: 24),
                        if (error.isNotEmpty)
                          Text(
                            error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        const SizedBox(height: 24),
                        CustomElevatedButton(
                          text: "Sign Up",
                          isEnabled: isFormValid,
                          onPressed: signUp,
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            // Navigate to login screen
                            Navigator.pop(context);
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                              children: const [
                                TextSpan(
                                  text: "Sign In",
                                  style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          TopBox(text: "Sign Up"),
        ],
      ),
    );
  }

  Widget buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

}
