import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/boarding_model.dart';

class PageViewItem extends StatelessWidget {
  final BoardingModel model;

  const PageViewItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 200),
          Image.asset(model.image, width: double.infinity, height: 250),
          SizedBox(height: 50),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.bold24,
          ),
          SizedBox(height: 25),
          Text(
            model.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.regular16,
          ),
        ],
      ),
    );
  }
}
