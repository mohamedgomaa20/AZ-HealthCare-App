
import 'package:flutter/material.dart';

import '../../models/water_intake_entry_model.dart'; // تأكد من تعديل المسار

  class WaterHistorySection extends StatelessWidget {
  final List<WaterIntakeEntryModel> entries;

  const WaterHistorySection({
    super.key,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),    width: 1,
        ),
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
            _buildEmptyState()
          else
            ...entries.map((entry) => WaterHistoryItem(entry: entry)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'No water intake recorded today',
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }
}

 class WaterHistoryItem extends StatelessWidget {
  final WaterIntakeEntryModel entry;

  const WaterHistoryItem({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = DateTime.fromMillisecondsSinceEpoch(entry.timestamp);
    final timeString =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // أيقونة الماء
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
}