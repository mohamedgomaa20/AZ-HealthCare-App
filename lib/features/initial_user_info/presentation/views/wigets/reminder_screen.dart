import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  final Function(TimeOfDay) onContinue;
  final TimeOfDay? initialTime;

  const ReminderScreen({
    super.key,
    required this.onContinue,
    this.initialTime,
  });

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  late int _selectedHour;
  late int _selectedMinute;
  late String _selectedAmPm; // 'AM' or 'PM'

  final FixedExtentScrollController _hourController = FixedExtentScrollController();
  final FixedExtentScrollController _minuteController = FixedExtentScrollController();

  final List<String> _hours = List.generate(12, (index) => (index + 1).toString().padLeft(2, '0')); // 01-12
  final List<String> _minutes = List.generate(60, (index) => index.toString().padLeft(2, '0')); // 00-59

  @override
  void initState() {
    super.initState();
    final now = TimeOfDay.now();
    _selectedHour = widget.initialTime?.hourOfPeriod ?? now.hourOfPeriod;
    _selectedMinute = widget.initialTime?.minute ?? now.minute;
    _selectedAmPm = widget.initialTime?.period == DayPeriod.am ? 'AM' : 'PM';

    // ضبط الـ controllers للقيم الافتراضية
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hourController.jumpToItem(_hours.indexOf(_selectedHour.toString().padLeft(2, '0')));
      _minuteController.jumpToItem(_minutes.indexOf(_selectedMinute.toString().padLeft(2, '0')));
    });
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  Widget _buildTimePickerColumn({
    required FixedExtentScrollController controller,
    required List<String> items,
    required int selectedValue,
    required ValueChanged<int> onSelectedItemChanged,
    String? suffix, // لإضافة AM/PM
  }) {
    return Expanded(
      child: SizedBox(
        height: 200,
        child: ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: 50,
          perspective: 0.005,
          physics: const FixedExtentScrollPhysics(),
          diameterRatio: 1.2,
          onSelectedItemChanged: onSelectedItemChanged,
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              final item = items[index % items.length];
              final isSelected = item == selectedValue.toString().padLeft(2, '0') || item == selectedValue.toString();
              return Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      item,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: isSelected ? Theme.of(context).primaryColor : Colors.white54,
                        fontSize: isSelected ? 48 : 36,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    if (isSelected && suffix != null)
                      Text(
                        ' $suffix',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              );
            },
            childCount: items.length,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "When would you like to\nreceive health check reminders?",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTimePickerColumn(
                  controller: _hourController,
                  items: _hours,
                  selectedValue: _selectedHour,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedHour = int.parse(_hours[index]);
                    });
                  },
                ),
                Text(
                  ':',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 48,
                  ),
                ),
                _buildTimePickerColumn(
                  controller: _minuteController,
                  items: _minutes,
                  selectedValue: _selectedMinute,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedMinute = int.parse(_minutes[index]);
                    });
                  },
                  suffix: _selectedAmPm, // عرض AM/PM مع الدقائق
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'You can always change this later.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white54),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              // تغيير النص إلى Finish بدلاً من Continue للشاشة الأخيرة
              onPressed: () {
                // TimeOfDay يتطلب ساعة بـ 24 ساعة (0-23)، HourOfPeriod هي 1-12
                int hour24 = _selectedHour;
                if (_selectedAmPm == 'PM' && _selectedHour != 12) {
                  hour24 += 12;
                } else if (_selectedAmPm == 'AM' && _selectedHour == 12) {
                  hour24 = 0; // 12 AM is 00 in 24-hour format
                }
                final reminderTime = TimeOfDay(hour: hour24, minute: _selectedMinute);
                widget.onContinue(reminderTime);
              },
              child: const Text('Finish'), // لاحظ تغيير النص هنا
            ),
          ),
        ],
      ),
    );
  }
}