import 'package:az_health_care/modules/login/login_screen.dart';
import 'package:az_health_care/shared/components/components.dart';
import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';
import '../../shared/styles/constants.dart';
import '../../shared/components/custom_elevated_button.dart';
import '../../shared/components/top_box.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  _LanguagesPageState createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  String? selectedLanguage;

  final localeOptions = {'العربية': 'ar', 'English': 'en'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: boxDecorationForBackground,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 250),

                Expanded(
                  child: ListView.builder(
                    itemCount: localeOptions.length,
                    itemBuilder: (context, index) {
                      String languageName = localeOptions.keys.toList()[index];
                      String languageTag = localeOptions[languageName]!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: CustomElevatedButton(
                          text: languageName,
                          onPressed: () {
                            setState(() {
                              selectedLanguage = languageTag;
                            });
                          },
                          isEnabled: true,
                          buttonColor:
                              selectedLanguage == languageTag
                                  ? selectedColor
                                  : unSelectedColor,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
                // Next button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomElevatedButton(
                    text: 'Next',
                    onPressed:
                        selectedLanguage != null
                            ? () {
                              // Navigate to the next screen
                              navigateTo(context, LoginScreen());
                            }
                            : () {},
                    isEnabled: selectedLanguage != null,
                    // Enable the Next button only if a language is selected
                  ),
                ),
                SizedBox(height: 250),
              ],
            ),
          ),
          TopBox(text: 'Select Language'),
        ],
      ),
    );
  }
}
