import 'package:flutter/material.dart';

import '../../../../../../../core/constants.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_text_styles.dart';

class PaymentMethodItem extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool? isSelected;
  final VoidCallback onTap;

  const PaymentMethodItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.blueGrayBackground2,
        borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
        border:
        isSelected!=null && isSelected!
                ? Border.all(color: AppColors.primaryColor, width: 2)
                : Border.all(color: AppColors.blueGrayBackground2, width: 2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(kPrimaryBorderRadius),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getIconColor(title),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: _getPaymentIcon(title)),
                ),

                SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.bold20),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                if (isSelected!=null && isSelected!)
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 14),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getIconColor(String title) {
    switch (title) {
      case 'PayPal':
        return Color(0xFF0070ba);
      case 'Google Pay':
        return Color(0xFF4285f4);
      case 'Apple Pay':
        return Color(0xFF000000);
      case 'Mastercard':
        return Color(0xFFeb001b);
      case 'Visa':
        return Color(0xFF1a1f71);
      case 'American Express':
        return Color(0xFF006fcf);
      default:
        return Color(0xFF2a2a2a);
    }
  }

  Widget _getPaymentIcon(String title) {
    switch (title) {
      case 'PayPal':
        return Text(
          'P',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        );
      case 'Google Pay':
        return Text(
          'G',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        );
      case 'Apple Pay':
        return Icon(Icons.apple, color: Colors.white, size: 20);
      case 'Mastercard':
        return Text(
          'MC',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        );
      case 'Visa':
        return Text(
          'V',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        );
      case 'American Express':
        return Text(
          'AE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        );
      default:
        return Icon(Icons.credit_card, color: Colors.white, size: 16);
    }
  }
}
