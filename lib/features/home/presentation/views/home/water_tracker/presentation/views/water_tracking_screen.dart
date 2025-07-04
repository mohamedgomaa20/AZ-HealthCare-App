import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import '../cubit/water_tracking_cubit.dart';
import '../cubit/water_tracking_state.dart';
import '../models/daily_water_goal_model.dart';
import '../models/interval_model.dart';
import '../models/water_intake_entry_model.dart';

//
//  class WaterIntakeEntryModel {
//   final int? id;
//   final String date;
//   final int timestamp;
//   final int amount;
//   final String glassType;
//
//   WaterIntakeEntryModel({
//     this.id,
//     required this.date,
//     required this.timestamp,
//     required this.amount,
//     required this.glassType,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'date': date,
//       'timestamp': timestamp,
//       'amount': amount,
//       'glassType': glassType,
//     };
//   }
//
//   factory WaterIntakeEntryModel.fromMap(Map<String, dynamic> map) {
//     return WaterIntakeEntryModel(
//       id: map['id'],
//       date: map['date'],
//       timestamp: map['timestamp'],
//       amount: map['amount'],
//       glassType: map['glassType'],
//     );
//   }
// }
//
// class DailyWaterGoalModel {
//   final String date;
//   final int targetAmount;
//   final int achievedAmount;
//
//   DailyWaterGoalModel({
//     required this.date,
//     required this.targetAmount,
//     required this.achievedAmount,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'date': date,
//       'targetAmount': targetAmount,
//       'achievedAmount': achievedAmount,
//     };
//   }
//
//   factory DailyWaterGoalModel.fromMap(Map<String, dynamic> map) {
//     return DailyWaterGoalModel(
//       date: map['date'],
//       targetAmount: map['targetAmount'],
//       achievedAmount: map['achievedAmount'],
//     );
//   }
//
//   double get progress => achievedAmount / targetAmount;
//   bool get isCompleted => achievedAmount >= targetAmount;
// }
//
// class IntervalModel {
//   final int minute;
//   final bool selected;
//   final String? displayName;
//
//   IntervalModel({
//     required this.minute,
//     this.selected = false,
//     this.displayName,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'minute': minute,
//       'selected': selected ? 1 : 0,
//       'displayName': displayName ?? _getDisplayName(),
//     };
//   }
//
//   factory IntervalModel.fromMap(Map<String, dynamic> map) {
//     return IntervalModel(
//       minute: map['minute'],
//       selected: map['selected'] == 1,
//       displayName: map['displayName'],
//     );
//   }
//
//   String _getDisplayName() {
//     if (minute < 60) {
//       return '${minute}m';
//     } else {
//       return '${minute ~/ 60}h';
//     }
//   }
// }

// // Enhanced States
// abstract class WaterTrackingState {}
//
// class WaterTrackingInitial extends WaterTrackingState {}
//
// class WaterTrackingLoading extends WaterTrackingState {}
//
// class WaterTrackingLoaded extends WaterTrackingState {
//   final List<WaterIntakeEntryModel> entries;
//   final DailyWaterGoalModel goal;
//   final List<IntervalModel> intervals;
//
//   WaterTrackingLoaded({
//     required this.entries,
//     required this.goal,
//     required this.intervals,
//   });
// }

// class WaterTrackingError extends WaterTrackingState {
//   final String message;
//   WaterTrackingError(this.message);
// }

// Enhanced Cubit
// class WaterTrackingCubit extends Cubit<WaterTrackingState> {
//   WaterTrackingCubit() : super(WaterTrackingInitial());
//
//   Future<void> loadData() async {
//     emit(WaterTrackingLoading());
//
//     try {
//       final today = DateTime.now().toIso8601String().split("T").first;
//
//        await Future.delayed(const Duration(milliseconds: 500));
//
//       final entries = <WaterIntakeEntryModel>[
//         WaterIntakeEntryModel(
//           id: 1,
//           date: today,
//           timestamp: DateTime.now().subtract(const Duration(hours: 2)).millisecondsSinceEpoch,
//           amount: 250,
//           glassType: 'Glass',
//         ),
//         WaterIntakeEntryModel(
//           id: 2,
//           date: today,
//           timestamp: DateTime.now().subtract(const Duration(hours: 4)).millisecondsSinceEpoch,
//           amount: 500,
//           glassType: 'Bottle',
//         ),
//       ];
//
//       final goal = DailyWaterGoalModel(
//         date: today,
//         targetAmount: 2000,
//         achievedAmount: 750,
//       );
//
//       final intervals = <IntervalModel>[
//         IntervalModel(minute: 15),
//         IntervalModel(minute: 30, selected: true),
//         IntervalModel(minute: 60),
//         IntervalModel(minute: 120),
//       ];
//
//       emit(WaterTrackingLoaded(
//         entries: entries,
//         goal: goal,
//         intervals: intervals,
//       ));
//     } catch (e) {
//       emit(WaterTrackingError('Failed to load data: $e'));
//     }
//   }
//
//   // Future<void> addWater(int amount, String glassType) async {
//   //   final currentState = state;
//   //   if (currentState is WaterTrackingLoaded) {
//   //     try {
//   //       final now = DateTime.now();
//   //       final date = now.toIso8601String().split("T").first;
//   //
//   //       final newEntry = WaterIntakeEntryModel(
//   //         id: currentState.entries.length + 1,
//   //         date: date,
//   //         timestamp: now.millisecondsSinceEpoch,
//   //         amount: amount,
//   //         glassType: glassType,
//   //       );
//   //
//   //       final updatedEntries = [newEntry, ...currentState.entries];
//   //       final newTotal = currentState.goal.achievedAmount + amount;
//   //
//   //       final updatedGoal = DailyWaterGoalModel(
//   //         date: date,
//   //         targetAmount: currentState.goal.targetAmount,
//   //         achievedAmount: newTotal,
//   //       );
//   //
//   //       emit(WaterTrackingLoaded(
//   //         entries: updatedEntries,
//   //         goal: updatedGoal,
//   //         intervals: currentState.intervals,
//   //       ));
//   //     } catch (e) {
//   //       emit(WaterTrackingError('Failed to add water: $e'));
//   //     }
//   //   }
//   // }
//
//   // Future<void> selectInterval(int minute) async {
//   //   final currentState = state;
//   //   if (currentState is WaterTrackingLoaded) {
//   //     final updatedIntervals = currentState.intervals.map((interval) {
//   //       return IntervalModel(
//   //         minute: interval.minute,
//   //         selected: interval.minute == minute,
//   //         displayName: interval.displayName,
//   //       );
//   //     }).toList();
//   //
//   //     emit(WaterTrackingLoaded(
//   //       entries: currentState.entries,
//   //       goal: currentState.goal,
//   //       intervals: updatedIntervals,
//   //     ));
//   //   }
//   // }
//
//   Future<void> updateGoal(int newTarget) async {
//     final currentState = state;
//     if (currentState is WaterTrackingLoaded) {
//       final updatedGoal = DailyWaterGoalModel(
//         date: currentState.goal.date,
//         targetAmount: newTarget,
//         achievedAmount: currentState.goal.achievedAmount,
//       );
//
//       emit(WaterTrackingLoaded(
//         entries: currentState.entries,
//         goal: updatedGoal,
//         intervals: currentState.intervals,
//       ));
//     }
//   }
// }

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
            _progressController.animateTo(
              state.goal.targetAmount.clamp(0.0, 1.0).toDouble(),
            );
          }
        },
        builder: (context, state) {
          if (state is WaterTrackingLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D4FF)),
              ),
            );
          }

          if (state is WaterTrackingError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
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

          if (state is WaterTrackingLoaded) {
            return CustomScrollView(
              slivers: [
                // Custom App Bar
                SliverAppBar(
                  expandedHeight: 120,
                  floating: false,
                  pinned: true,
                  backgroundColor: const Color(0xFF0D1117),
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text(
                      'Water Tracker',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () => _showSettingsSheet(context, state),
                    ),
                  ],
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                         _buildProgressSection(state.goal),
                        const SizedBox(height: 24),

                         _buildQuickAddSection(context),
                        const SizedBox(height: 24),

                         _buildReminderSection(context, state.intervals),
                        const SizedBox(height: 24),

                         _buildHistorySection(state.entries),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildProgressSection(DailyWaterGoalModel goal) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF00D4FF).withOpacity(0.1),
            const Color(0xFF0099CC).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00D4FF).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
           SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                 Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 8,
                    ),
                  ),
                ),

                 AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        value: _progressAnimation.value * goal.targetAmount,
                        strokeWidth: 8,
                        backgroundColor: Colors.transparent,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF00D4FF),
                        ),
                      ),
                    );
                  },
                ),

                 Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.water_drop,
                      size: 32,
                      color: Color(0xFF00D4FF),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${goal.achievedAmount}ml',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'of ${goal.targetAmount}ml',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                'Progress',
                '${(goal.targetAmount * 100).toInt()}%',
                Icons.trending_up,
              ),
              _buildStatItem(
                'Remaining',
                '${(goal.targetAmount - goal.achievedAmount).clamp(0, goal.targetAmount)}ml',
                Icons.schedule,
              ),
              _buildStatItem(
                'Glasses',
                '${goal.achievedAmount ~/ 250}',
                Icons.local_drink,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF00D4FF), size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7)),
        ),
      ],
    );
  }

  Widget _buildQuickAddSection(BuildContext context) {
    final quickAmounts = [
      {'amount': 250, 'label': 'Glass', 'icon': Icons.local_drink},
      {'amount': 500, 'label': 'Bottle', 'icon': Icons.sports_bar},
      {'amount': 750, 'label': 'Large', 'icon': Icons.local_bar},
      {'amount': 1000, 'label': 'Jug', 'icon': Icons.coffee},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Add',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: quickAmounts.length,
            itemBuilder: (context, index) {
              final item = quickAmounts[index];
              return _buildQuickAddButton(
                context,
                item['amount'] as int,
                item['label'] as String,
                item['icon'] as IconData,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAddButton(
    BuildContext context,
    int amount,
    String label,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        context.read<WaterTrackingCubit>().addWater(amount, label);
        _rippleController.forward().then((_) {
          _rippleController.reset();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF00D4FF).withOpacity(0.1),
              const Color(0xFF0099CC).withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF00D4FF).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: const Color(0xFF00D4FF)),
            const SizedBox(height: 8),
            Text(
              '${amount}ml',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderSection(
    BuildContext context,
    List<IntervalModel> intervals,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reminder Intervals',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                intervals.map((interval) {
                  return _buildIntervalChip(context, interval);
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIntervalChip(BuildContext context, IntervalModel interval) {
    return GestureDetector(
      onTap: () {
        context.read<WaterTrackingCubit>().selectInterval(interval.minute);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              interval.selected ? const Color(0xFF00D4FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                interval.selected
                    ? const Color(0xFF00D4FF)
                    : Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          interval.displayName ?? '${interval.minute}m',
          style: TextStyle(
            color: interval.selected ? Colors.black : Colors.white,
            fontWeight: interval.selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildHistorySection(List<WaterIntakeEntryModel> entries) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today\'s History',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          if (entries.isEmpty)
            const Center(
              child: Text(
                'No water intake recorded today',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            )
          else
            ...entries.map((entry) => _buildHistoryItem(entry)),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(WaterIntakeEntryModel entry) {
    final time = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);
    final timeString =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF00D4FF).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.water_drop,
              color: Color(0xFF00D4FF),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${entry.amount}ml - ${entry.glassType}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  timeString,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSettingsSheet(BuildContext context, WaterTrackingLoaded state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161B22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.flag, color: Color(0xFF00D4FF)),
                  title: const Text(
                    'Daily Goal',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    '${state.goal.targetAmount}ml',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {
                    Navigator.pop(context);
                    _showGoalDialog(context, state.goal.targetAmount);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.notifications,
                    color: Color(0xFF00D4FF),
                  ),
                  title: const Text(
                    'Notifications',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: const Color(0xFF00D4FF),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.history, color: Color(0xFF00D4FF)),
                  title: const Text(
                    'View History',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to history page
                  },
                ),
              ],
            ),
          ),
    );
  }

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
  //               controller: TextEditingController(
  //                 text: currentGoal.toString(),
  //               ),
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

  void _showGoalDialog(BuildContext context, int currentGoal) {
    final controller = TextEditingController(text: currentGoal.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        title: const Text(
          'Set Daily Goal',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Enter goal in ml',
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newGoal = int.tryParse(controller.text) ?? currentGoal;
              context.read<WaterTrackingCubit>().updateGoal(newGoal);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
