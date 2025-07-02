import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/utils/app_images.dart';
import '../../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../../core/utils/app_images.dart';
import '../../../../../../../../core/utils/app_text_styles.dart';

class HeaderProfileWidget extends StatelessWidget {
  const HeaderProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 32,
            height: 32,

            child: Image.asset(AppImages.appMainIcon),
          ),
          Text(
            'Profile',
            style: AppTextStyles.bold24.copyWith(color: AppColors.darkGray),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.rectangle_grid_2x2_fill),
          ),
        ],
      ),
    );
    ;
  }
}
