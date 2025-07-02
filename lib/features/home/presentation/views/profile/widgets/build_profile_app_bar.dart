import 'package:flutter/material.dart';

import '../../../../../../../../core/utils/app_images.dart';


class BuildProfileAppBar extends StatelessWidget {
  const BuildProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Image.asset(AppImages.appMainIcon, width: 35, height: 35),

          Expanded(
            child: Center(
              child: Text(
                'Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          Icon(Icons.more_vert, color: Colors.white, size: 24),
        ],
      ),
    );
    ;
  }
}
