import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class WatchIdInputWidget extends StatelessWidget {
  // final TextEditingController controller;
  // final Function(String) onChanged;
  // final VoidCallback onClear;

  const WatchIdInputWidget({
    super.key,
    // required this.controller,
    // required this.onChanged,
    // required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.watch_outlined, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Watch ID',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          TextField(
            controller: controller,
            style: TextStyle(color: Colors.white, fontSize: 16),
            onChanged: (value) {},
            decoration: InputDecoration(
              enabledBorder: buildOutlineInputBorder(),
              disabledBorder: buildOutlineInputBorder(),
              focusedBorder: buildOutlineInputBorder(),
              prefixIcon: Icon(Icons.sensors_outlined),
              hintText: 'Enter Watch ID',
              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),

              suffixIcon:
                  controller.text.isNotEmpty
                      ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey[400],
                          size: 20,
                        ),
                        onPressed: () {},
                      )
                      : null,
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.grey),
    );
  }
}
