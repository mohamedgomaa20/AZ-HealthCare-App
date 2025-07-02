import 'package:flutter/material.dart';

import 'congratulations_confetti_layer.dart';
import 'congratulations_content.dart';

class CongratulationsViewBody extends StatelessWidget {
  const CongratulationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [ConfettiLayer(count: 30), CongratulationsContent()],
    );
  }
}
