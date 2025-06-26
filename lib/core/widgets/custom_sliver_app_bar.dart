import 'package:flutter/material.dart';
import 'package:az_health_care/core/utils/app_colors.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverAppBar(
        expandedHeight: 150,
        pinned: true,
        elevation: 4,
        forceElevated: true,
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: LayoutBuilder(
          builder: (context, constraints) {
            final isCollapsed =
                constraints.biggest.height <= kToolbarHeight + 10;
            final double expandedTitleLeft = 5;
            final double collapsedTitleLeft = 60;

            final double titleLeft =
                isCollapsed
                    ? collapsedTitleLeft
                    : expandedTitleLeft +
                        (collapsedTitleLeft - expandedTitleLeft) *
                            (1 -
                                (constraints.biggest.height - kToolbarHeight) /
                                    (200 - kToolbarHeight));

            return FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: titleLeft, bottom: 16),
              title: AnimatedScale(
                scale: isCollapsed ? 0.8 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
