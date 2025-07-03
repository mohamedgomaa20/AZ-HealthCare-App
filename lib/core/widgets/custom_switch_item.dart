import 'package:flutter/material.dart';

class CustomSwitchItem extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;

  const CustomSwitchItem({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFFF4757),
            inactiveThumbColor: const Color(0xFF666666),
            inactiveTrackColor: const Color(0xFF333333),
          ),
        ],
      ),
    );
  }
}
