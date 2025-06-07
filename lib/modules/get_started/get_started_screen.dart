import 'package:az_health_care/modules/choose_language/choose_language_screen.dart';
import 'package:az_health_care/shared/components/components.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/constants.dart';
import '../../shared/components/custom_elevated_button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: boxDecorationForBackground,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Image.asset(
                  'assets/images/onboard_1.png',
                  fit: BoxFit.cover,
                  height: 250,
                ),
              ),
              SizedBox(height: 80),
              Text(
                'AZ Healthcare',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  fontFamily: 'Serif',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Now you have an AI-powered doctor in your phone, Ready to monitor your health and daily activities',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cursive',
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              CustomElevatedButton(
                text: 'Get Started',
                onPressed: () {
                  navigateTo(
                    context,
                    LanguagesPage( ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
