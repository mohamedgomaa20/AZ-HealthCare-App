import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
  final Function(TimeOfDay) onReminderTimeSelected;
  final TimeOfDay? initialTime;

  const ReminderScreen({
    super.key,
    required this.onReminderTimeSelected,
    this.initialTime,
  });

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  late int _selectedHour;
  late int _selectedMinute;
  late String _selectedAmPm;

  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  final List<String> _hours = List.generate(12, (index) => (index + 1).toString().padLeft(2, '0')); // 01-12
  final List<String> _minutes = List.generate(60, (index) => index.toString().padLeft(2, '0')); // 00-59

  @override
  void initState() {
    super.initState();

    final now = widget.initialTime ?? TimeOfDay.now();

    _selectedHour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    _selectedMinute = now.minute;
    _selectedAmPm = now.period == DayPeriod.am ? 'AM' : 'PM';

    int initialHourIndex = _hours.indexOf(_selectedHour.toString().padLeft(2, '0'));
    int initialMinuteIndex = _minutes.indexOf(_selectedMinute.toString().padLeft(2, '0'));

    _hourController = FixedExtentScrollController(
      initialItem: initialHourIndex.clamp(0, _hours.length - 1),
    );
    _minuteController = FixedExtentScrollController(
      initialItem: initialMinuteIndex.clamp(0, _minutes.length - 1),
    );

    // *** IMPORTANT CHANGE HERE ***
    // Defer the call to _updateParentTime() until after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateParentTime();
    });
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  void _updateParentTime() {
    int hour24 = _selectedHour;
    if (_selectedAmPm == 'PM' && _selectedHour != 12) {
      hour24 += 12;
    } else if (_selectedAmPm == 'AM' && _selectedHour == 12) {
      hour24 = 0;
    }
    final currentTime = TimeOfDay(hour: hour24, minute: _selectedMinute);
    widget.onReminderTimeSelected(currentTime);
  }

  Widget _buildTimePickerColumn({
    required FixedExtentScrollController controller,
    required List<String> items,
    required int selectedValue,
    required ValueChanged<int> onSelectedItemChanged,
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
          onSelectedItemChanged: (index) {
            onSelectedItemChanged(index);
            _updateParentTime(); // Keep this here for user interaction
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              final item = items[index % items.length];
              final isSelected = item == selectedValue.toString().padLeft(2, '0') || item == selectedValue.toString();
              return Center(
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: isSelected ? Theme.of(context).primaryColor : Colors.white54,
                    fontSize: isSelected ? 48 : 36,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            },
            childCount: items.length,
          ),
        ),
      ),
    );
  }

  Widget _buildAmPmToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAmPmButton('AM'),
          _buildAmPmButton('PM'),
        ],
      ),
    );
  }

  Widget _buildAmPmButton(String period) {
    final bool isSelected = _selectedAmPm == period;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAmPm = period;
          _updateParentTime(); // Keep this here for user interaction
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          period,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: isSelected ? Colors.white : Colors.white70,
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
                ),
                const SizedBox(width: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildAmPmToggle(),
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
        ],
      ),
    );
  }
}