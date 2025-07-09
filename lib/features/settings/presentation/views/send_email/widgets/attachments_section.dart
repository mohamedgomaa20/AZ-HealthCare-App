import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../manager/send_email_cubit/send_email_cubit.dart';

class AttachmentsSection extends StatelessWidget {
  const AttachmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = SendEmailCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Attachments", style: AppTextStyles.semiBold16),
            TextButton.icon(
              onPressed: () => _pickFile(context, cubit),
              icon: Icon(Icons.attach_file, size: 20),
              label: Text("Add File"),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),

        if (cubit.attachments.isNotEmpty) ...[
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.grayColor.withOpacity(0.3)),
            ),
            child: Column(
              children:
                  cubit.attachments.asMap().entries.map((entry) {
                    int index = entry.key;
                    String fileName = entry.value.split('/').last;

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.attach_file,
                            size: 16,
                            color: AppColors.grayColor,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              fileName,
                              style: AppTextStyles.medium14,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () => cubit.removeAttachment(index),
                            icon: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.red,
                            ),
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.all(4),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _pickFile(BuildContext context, SendEmailCubit cubit) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        for (PlatformFile file in result.files) {
          if (file.path != null) {
            cubit.addAttachment(file.path!);
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error picking file: $e")));
    }
  }
}
