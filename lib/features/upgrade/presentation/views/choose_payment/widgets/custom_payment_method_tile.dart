import 'package:az_health_care/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import '../../../../../payment_methods/data/models/payment_method_model.dart';

class CustomPaymentMethodTile extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final bool? isSelected;
  final bool showStatus;
  final bool showCheckMark;
  final VoidCallback? onTap;

  const CustomPaymentMethodTile({
    super.key,
    required this.paymentMethod,
    this.isSelected,
    this.showStatus = false,
    this.showCheckMark = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isApple = paymentMethod.name == 'Apple Pay';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
        border: isSelected != null && isSelected == true
            ? Border.all(color: AppColors.primaryColor, width: 2)
            : Border.all(color: AppColors.blueGrayBackground2, width: 2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: paymentMethod.iconColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    paymentMethod.icon,
                    color: isApple ? Colors.black : Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(paymentMethod.name, style: AppTextStyles.bold16),
                      const SizedBox(height: 4),
                      Text(
                        paymentMethod.subtitle,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (showStatus)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Text(
                      paymentMethod.isLinked ? 'Linked' : 'Not Linked',
                      style: AppTextStyles.semiBold14,
                    ),
                  ),
                if (showCheckMark && isSelected == true)
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 14),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
