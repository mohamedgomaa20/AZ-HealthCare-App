import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/water_tracking_cubit.dart';
import '../../cubit/water_tracking_state.dart';

class IntervalSelector extends StatelessWidget {
  const IntervalSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterTrackingCubit, WaterTrackingState>(
      builder: (context, state) {
        if (state is WaterTrackingLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Reminder Interval:"),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: state.intervals.map((interval) {
                  final isSelected = interval.selected;
                  return ChoiceChip(
                    label: Text(interval.displayName),
                    selected: isSelected,
                    onSelected: (_) => context
                        .read<WaterTrackingCubit>()
                        .selectInterval(interval.minute),
                  );
                }).toList(),
              ),
            ],
          );
        } else if (state is WaterTrackingLoading) {
          return const CircularProgressIndicator();
        } else {
          return const Text("No data found");
        }
      },
    );
  }
}
