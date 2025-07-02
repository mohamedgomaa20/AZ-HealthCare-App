import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ConfettiLayer extends StatefulWidget {
  final int count;

  const ConfettiLayer({super.key, this.count = 20});

  @override
  State<ConfettiLayer> createState() => _ConfettiLayerState();
}

class _ConfettiLayerState extends State<ConfettiLayer>
    with TickerProviderStateMixin {
  late List<AnimationController> controllers;
  late List<Animation<double>> animations;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      widget.count,
      (index) => AnimationController(
        duration: Duration(milliseconds: 2000 + (index * 100)),
        vsync: this,
      ),
    );

    animations =
        controllers.map((controller) {
          return Tween<double>(begin: -50, end: 900).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut),
          );
        }).toList();

    for (var controller in controllers) {
      controller.repeat();
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      AppColors.redAccent,
      AppColors.blueAccent,
      AppColors.amberAccent,
      AppColors.greenAccent,
      AppColors.purpleAccent,
      AppColors.pinkAccent,

    ];

    return Stack(
      children: List.generate(widget.count, (index) {
        return AnimatedBuilder(
          animation: animations[index],
          builder: (context, child) {
            return Positioned(
              top: animations[index].value,
              left: 30 + (index * 18.0) % MediaQuery.of(context).size.width,
              child: Transform.rotate(
                angle: animations[index].value * 0.01,
                child: Container(
                  width: index % 2 == 0 ? 6 : 4,
                  height: index % 3 == 0 ? 16 : 12,
                  decoration: BoxDecoration(
                    color: colors[index % colors.length],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

/*
 decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     Color(0xFF0F1419),
        //     Color(0xFF1A1F29),
        //     Color(0xFF0F1419),
        //   ],
        // ),
        borderRadius: BorderRadius.circular(24),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.8),
        //     blurRadius: 20,
        //     offset: Offset(0, 10),
        //   ),
        // ],
      ),
 */
