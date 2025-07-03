import 'package:flutter/cupertino.dart';

class PaymentMethod {
  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final bool isLinked;
  final Color iconColor;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.isLinked,
    required this.iconColor,
  });
}
