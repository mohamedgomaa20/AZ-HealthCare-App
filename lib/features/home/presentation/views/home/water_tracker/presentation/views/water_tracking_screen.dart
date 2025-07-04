import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/features/home/presentation/views/home/water_tracker/presentation/views/water_tracker_settings_screen.dart';
 import 'package:az_health_care/features/home/presentation/views/home/water_tracker/presentation/views/widgets/quick_add_water_section.dart';
import 'package:az_health_care/features/home/presentation/views/home/water_tracker/presentation/views/widgets/water_history_section.dart';
import 'package:az_health_care/features/home/presentation/views/home/water_tracker/presentation/views/widgets/water_progress_widget.dart';
import 'package:az_health_care/features/home/presentation/views/home/water_tracker/presentation/views/widgets/water_reminder_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/water_tracking_cubit.dart';
import '../cubit/water_tracking_state.dart';
import '../models/daily_water_goal_model.dart';

class WaterTrackingScreen extends StatefulWidget {
  const WaterTrackingScreen({super.key});

  @override
  State<WaterTrackingScreen> createState() => _WaterTrackingScreenState();
}

class _WaterTrackingScreenState extends State<WaterTrackingScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _rippleController;
  late Animation<double> _progressAnimation;
  late Animation<double> _rippleAnimation;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOut),
    );

    context.read<WaterTrackingCubit>().loadData();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WaterTrackingCubit, WaterTrackingState>(
        listener: (context, state) {
          if (state is WaterTrackingLoaded) {
            final goal = state.goal;
            double progress = goal.achievedAmount / goal.targetAmount;
            progress = progress.clamp(0.0, 1.0);

            _progressAnimation = Tween<double>(
              begin: _progressAnimation.value,
              end: progress,
            ).animate(
              CurvedAnimation(
                parent: _progressController,
                curve: Curves.easeInOut,
              ),
            );

            _progressController.forward(from: 0);
          }
        },

        builder: (context, state) {
          var cubit = context.read<WaterTrackingCubit>();

          if (state is WaterTrackingError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),

                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        () => context.read<WaterTrackingCubit>().loadData(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              // Custom App Bar
              SliverAppBar(
                expandedHeight: 0,
                floating: false,
                pinned: true,
                surfaceTintColor: AppColors.transparentColor,
                backgroundColor: const Color(0xFF0D1117),
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Water Tracker',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // background: Container(
                  //   decoration: const BoxDecoration(
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //       colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                  //     ),
                  //   ),
                  // ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => const WaterTrackerSettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
                // actions: [
                //   IconButton(
                //     icon: const Icon(Icons.settings, color: Colors.white),
                //     onPressed: () => _showSettingsSheet(context, state),
                //   ),
                // ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      WaterProgressWidget(
                        goal:
                            cubit.goal ??
                            DailyWaterGoalModel(
                              achievedAmount: 0,
                              date:
                                  DateTime.now()
                                      .toIso8601String()
                                      .split("T")
                                      .first,
                              targetAmount: 1000,
                            ),
                        progressAnimation: _progressAnimation,
                      ),
                      const SizedBox(height: 24),

                      QuickAddWaterSection(rippleController: _rippleController),
                      const SizedBox(height: 24),
                      WaterReminderSection(intervals: cubit.intervals),
                      const SizedBox(height: 24),
                      WaterHistorySection(entries: cubit.entries),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  //
  //   void _showSettingsSheet(BuildContext context, WaterTrackingLoaded state) {
  //     showModalBottomSheet(
  //       context: context,
  //       backgroundColor: const Color(0xFF161B22),
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //       ),
  //       builder:
  //           (context) => Container(
  //             padding: const EdgeInsets.all(20),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Text(
  //                   'Settings',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 20),
  //                 ListTile(
  //                   leading: const Icon(Icons.flag, color: Color(0xFF00D4FF)),
  //                   title: const Text(
  //                     'Daily Goal',
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                   subtitle: Text(
  //                     '${state.goal.targetAmount}ml',
  //                     style: const TextStyle(color: Colors.grey),
  //                   ),
  //                   trailing: const Icon(Icons.chevron_right, color: Colors.grey),
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     _showGoalDialog(context, state.goal.targetAmount);
  //                   },
  //                 ),
  //                 ListTile(
  //                   leading: const Icon(
  //                     Icons.notifications,
  //                     color: Color(0xFF00D4FF),
  //                   ),
  //                   title: const Text(
  //                     'Notifications',
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                   trailing: Switch(
  //                     value: true,
  //                     onChanged: (value) {},
  //                     activeColor: const Color(0xFF00D4FF),
  //                   ),
  //                 ),
  //                 ListTile(
  //                   leading: const Icon(Icons.history, color: Color(0xFF00D4FF)),
  //                   title: const Text(
  //                     'View History',
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                   trailing: const Icon(Icons.chevron_right, color: Colors.grey),
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     // Navigate to history page
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //     );
  //   }
  //
  //   void _showGoalDialog(BuildContext context, int currentGoal) {
  //     final controller = TextEditingController(text: currentGoal.toString());
  //
  //     showDialog(
  //       context: context,
  //       builder:
  //           (context) => AlertDialog(
  //             backgroundColor: const Color(0xFF161B22),
  //             title: const Text(
  //               'Set Daily Goal',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //             content: TextField(
  //               controller: controller,
  //               keyboardType: TextInputType.number,
  //               style: const TextStyle(color: Colors.white),
  //               decoration: const InputDecoration(
  //                 hintText: 'Enter goal in ml',
  //                 hintStyle: TextStyle(color: Colors.grey),
  //                 border: OutlineInputBorder(),
  //               ),
  //             ),
  //             // actions: [
  //             //   IconButton(
  //             //     icon: const Icon(Icons.settings, color: Colors.white),
  //             //     onPressed: () {
  //             //       Navigator.push(
  //             //         context,
  //             //         MaterialPageRoute(
  //             //           builder: (context) => const WaterTrackerSettingsScreen(),
  //             //         ),
  //             //       );
  //             //     },
  //             //   ),
  //             // ],
  //             actions: [
  //               TextButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 child: const Text('Cancel'),
  //               ),
  //               TextButton(
  //                 onPressed: () async {
  //                   final newGoal = int.tryParse(controller.text) ?? currentGoal;
  //                   await BlocProvider.of<WaterTrackingCubit>(
  //                     context,
  //                   ).updateGoal(newGoal);
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('Save'),
  //               ),
  //             ],
  //           ),
  //     );
  //   }
  // }
  //
  // void _showGoalDialog(BuildContext context, int currentGoal) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Builder(
  //         builder: (dialogContext) {
  //           final cubit = dialogContext.read<WaterTrackingCubit>();
  //           return AlertDialog(
  //             title: Text("Edit Goal"),
  //             content: TextField(
  //               controller: TextEditingController(text: currentGoal.toString()),
  //               keyboardType: TextInputType.number,
  //               onChanged: (value) {
  //                 cubit.updateGoal(int.tryParse(value) ?? currentGoal);
  //               },
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
