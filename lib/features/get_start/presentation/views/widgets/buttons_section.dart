import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../Auth/presentation/views/login/login_view.dart';
import '../../../../Auth/presentation/views/sign_up/sign_up_view.dart';
import 'google_button.dart';

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GoogleButton(),
        const SizedBox(height: 50),
        CustomButton(
          buttonText: 'Sign Up',
          onPressed: () {
            Navigator.pushNamed(context, SignUpView.routeName);
          },
        ),
        const SizedBox(height: 10),
        CustomButton(
          buttonText: 'Sign In',
          onPressed: () {
            Navigator.pushNamed(context, LoginView.routeName);
          },
          backgroundColor: AppColors.darkGray,
        ),
      ],
    );
  }
}
