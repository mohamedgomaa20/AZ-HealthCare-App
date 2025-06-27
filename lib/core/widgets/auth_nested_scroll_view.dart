import 'package:flutter/material.dart';
import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/widgets/custom_sliver_app_bar.dart';

import '../utils/app_text_styles.dart';

class AuthNestedScrollView extends StatelessWidget {
  final String appBarTitle;
  final String? descriptionText;
  final Widget child;

  const AuthNestedScrollView({
    super.key,
    required this.appBarTitle,
    this.descriptionText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder:
          (context, innerBoxIsScrolled) => [
            CustomSliverAppBar(title: appBarTitle),
          ],
      body: Builder(
        builder:
            (context) => CustomScrollView(
              slivers: [
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        if (descriptionText != null)
                          Text(descriptionText!, style: AppTextStyles.medium14),
                        if (descriptionText != null) const SizedBox(height: 45),
                        child,
                      ],
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
