import 'package:az_health_care/features/home/presentation/views/home/water_tracker/water_tracker_view.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_text_styles.dart';

class WaterIntakeWidget extends StatelessWidget {
  const WaterIntakeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundStepColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Water Intake', style: AppTextStyles.bold18),
              SizedBox(height: 10),
              Text(
                '7000ml / 2000ml',
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.blueDarkColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '100% Complete',
                style: TextStyle(color: Colors.green, fontSize: 12),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: 100,
                child: LinearProgressIndicator(
                  value: .5,
                  color: AppColors.blueColor,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: AppColors.backgroundLinearColor,
                  minHeight: 15,
                ),
              ),
             ],
          ),
          SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.water_drop, color: AppColors.blueColor, size: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WaterTrackerHome(),));
                    
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundArrowColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
