import 'package:flutter/material.dart';
import 'logo_and_title_section.dart';
import 'buttons_section.dart';
import 'footer_links_section.dart';

class GetStartViewBody extends StatelessWidget {
  const GetStartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          LogoAndTitleSection(),
          SizedBox(height: 40),
          ButtonsSection(),
          SizedBox(height: 32),
          FooterSection(),
        ],
      ),
    );
  }
}
