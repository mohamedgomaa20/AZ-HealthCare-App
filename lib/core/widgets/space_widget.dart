import 'package:flutter/material.dart';

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace(this.value, {super.key});

  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value!);
  }
}

class VerticalSpace extends StatelessWidget {
  const VerticalSpace(this.value, {super.key});

  final double? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value!);
  }
}
