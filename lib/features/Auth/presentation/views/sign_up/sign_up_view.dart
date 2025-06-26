//  import 'package:az_health_care/features/Auth/presentation/views/sign_up/widgets/sign_up_view_body.dart';
// import 'package:flutter/material.dart';
//
//
// class SignUpView extends StatelessWidget {
//   const SignUpView({super.key});
//    static const routeName = "signUpView";
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: SignUpViewBody());
//
//   }
// }
// sign_up_view.dart
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/core/utils/app_colors.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  static const routeName = "signUpView";

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                floating: false,
                snap: false,
                elevation: 4,
                // إضافة ظل عند التمرير
                forceElevated: innerBoxIsScrolled,
                backgroundColor: AppColors.backgroundColor,
                surfaceTintColor: Colors.transparent,
                // يمنع التأثير الشفاف
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    final isCollapsed =
                        constraints.biggest.height <= kToolbarHeight + 10;
                    final double expandedTitleLeft =
                        24; // تباعد كبير من اليسار عند الفتح
                    final double collapsedTitleLeft =
                        50; // تباعد أكبر لتجنب سهم الرجوع عند التمرير

                    // تحريك النص تدريجياً عند التمرير
                    final double titleLeft =
                        isCollapsed
                            ? collapsedTitleLeft
                            : expandedTitleLeft +
                                (collapsedTitleLeft - expandedTitleLeft) *
                                    (1 -
                                        (constraints.biggest.height -
                                                kToolbarHeight) /
                                            (200 - kToolbarHeight));

                    return FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(
                        left: titleLeft,
                        bottom: 16,
                      ),
                      title: AnimatedScale(
                        scale: isCollapsed ? 0.8 : 1.0,
                        duration: Duration(milliseconds: 200),
                        child: Text(
                          'Join A2Z Care Today',
                          style: TextStyle(
                            fontSize:
                                isCollapsed ? 15 : 22, // حجم أكبر عند الفتح
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Create your account and start monitoring your health",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),
              const Text("UserName", style: AppTextStyles.inputLabelWhite),
              const SizedBox(height: 8),
              TextField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'UserName',
                  hintStyle: AppTextStyles.regular14Grey,
                  filled: true,
                  fillColor: AppColors.buttonColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Email", style: AppTextStyles.inputLabelWhite),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: AppTextStyles.regular14Grey,
                  filled: true,
                  fillColor: AppColors.buttonColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Create Password",
                style: AppTextStyles.inputLabelWhite,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Create Password',
                  hintStyle: AppTextStyles.regular14Grey,
                  filled: true,
                  fillColor: AppColors.buttonColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed:
                        () => setState(
                          () => _passwordVisible = !_passwordVisible,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Confirm Password",
                style: AppTextStyles.inputLabelWhite,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmPasswordController,
                obscureText: !_confirmPasswordVisible,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: AppTextStyles.regular14Grey,
                  filled: true,
                  fillColor: AppColors.buttonColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed:
                        () => setState(
                          () =>
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged:
                        (value) =>
                            setState(() => _agreedToTerms = value ?? false),
                    activeColor: Colors.red,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "I agree to A2ZCare ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Terms & Conditions",
                      style: AppTextStyles.redLink14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Sign in",
                      style: AppTextStyles.redLink14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "or continue with",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.g_mobiledata,
                  size: 28,
                  color: Colors.white,
                ),
                label: const Text(
                  "Sign up with Google",
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(buttonText: "Sign Up", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
