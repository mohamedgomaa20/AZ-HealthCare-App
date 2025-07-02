import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class FAQQuestionTile extends StatefulWidget {
  final String question;
  final String answer;

  const FAQQuestionTile({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FAQQuestionTile> createState() => _FAQQuestionTileState();
}

class _FAQQuestionTileState extends State<FAQQuestionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:   EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            color: Colors.transparent,
            child: ExpansionTile(
              onExpansionChanged: (val) => setState(() => isExpanded = val),
              tilePadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
              collapsedBackgroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              title: Text(
                widget.question,
                style: AppTextStyles.bold18.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
              trailing: Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 30,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 25),
                  child: Divider(
                    color: AppColors.white10Color,
                    thickness: 1,
                    height: 16,
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20, bottom:20),
                  child: Align(
                      alignment:    Alignment.centerLeft,
                    child: Text(
                      widget.answer,
                      textAlign: TextAlign.start,
                      style: AppTextStyles.semiBold16,
                    ),
                  ),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
