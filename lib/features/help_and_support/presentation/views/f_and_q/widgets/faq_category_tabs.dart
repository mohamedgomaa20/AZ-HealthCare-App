import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class FAQCategoryTabs extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const FAQCategoryTabs({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = category == selectedCategory;

            return GestureDetector(
              onTap: () => onCategorySelected(category),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border:
                      isSelected
                          ? Border.all(color: AppColors.transparentColor)
                          : Border.all(color: AppColors.white30Color),
                  color:
                      isSelected
                          ? AppColors
                              .primaryColor // selected background
                          : AppColors.transparentColor, // unselected background
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  category,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bold16.copyWith(
                    color:
                        isSelected
                            ? AppColors
                                .whiteColor // selected text color
                            : AppColors.white70Color, // unselected text color
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
