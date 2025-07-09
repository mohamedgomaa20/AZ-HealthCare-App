import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class UploadButtonWidget extends StatelessWidget {
  final VoidCallback onUpload;
  final bool isLoading;

  const UploadButtonWidget({
    super.key,
    required this.onUpload,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onUpload,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        elevation: 3,
        shadowColor: AppColors.primaryColor.withOpacity(0.3),
      ),
      child: isLoading
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            'Uploading...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_upload_outlined, size: 20,color: AppColors.whiteColor,),
          SizedBox(width: 8),
          Text(
            'Upload Sensor Data',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
