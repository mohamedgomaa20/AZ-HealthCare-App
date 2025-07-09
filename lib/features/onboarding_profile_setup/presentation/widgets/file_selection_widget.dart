import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class FileSelectionWidget extends StatelessWidget {
  final VoidCallback onSelectFile;
  final String? selectedFileName;
  final bool isFileSelected;

  const FileSelectionWidget({
    super.key,
    required this.onSelectFile,
    this.selectedFileName,
    required this.isFileSelected,
  });

  @override
  Widget build(BuildContext context) {
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
              Icon(
                Icons.insert_drive_file_outlined,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'JSON File',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: 15),

          CustomButton(text: 'Select JSON File', onPressed: onSelectFile,fontSize: 16,height: 45,),
          SizedBox(height: 5),
          if (isFileSelected && selectedFileName != null)
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selectedFileName!,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// Container(
//   margin: EdgeInsets.only(top: 5),
//   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//   decoration: BoxDecoration(
//     color: Colors.green.withOpacity(0.1),
//     borderRadius: BorderRadius.circular(8),
//     border: Border.all(
//       color: Colors.green.withOpacity(0.3),
//       width: 1,
//     ),
//   ),
//   child: Row(
//     children: [
//       Icon(
//         Icons.check_circle,
//         color: Colors.green,
//         size: 16,
//       ),
//       SizedBox(width: 8),
//       Expanded(
//         child: Text(
//           selectedFileName!,
//           style: TextStyle(
//             color: Colors.green,
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
