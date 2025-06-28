import 'package:flutter/material.dart';

class BirthdayScreen extends StatefulWidget {
  // تم تغيير onContinue إلى onBirthdaySelected
  final Function(DateTime) onBirthdaySelected; // جديد

  const BirthdayScreen({super.key, required this.onBirthdaySelected}); // جديد

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  int _selectedMonth = DateTime.now().month;
  int _selectedDay = DateTime.now().day;
  int _selectedYear = DateTime.now().year - 20;

  final FixedExtentScrollController _monthController = FixedExtentScrollController();
  final FixedExtentScrollController _dayController = FixedExtentScrollController();
  final FixedExtentScrollController _yearController = FixedExtentScrollController();

  final List<String> _months = List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));
  final List<String> _days = List.generate(31, (index) => (index + 1).toString().padLeft(2, '0'));
  final List<String> _years = List.generate(100, (index) => (DateTime.now().year - index).toString());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _monthController.jumpToItem(_selectedMonth - 1);
      _dayController.jumpToItem(_selectedDay - 1);
      _yearController.jumpToItem(_years.indexOf(_selectedYear.toString()));
    });
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  Widget _buildPickerColumn({
    required FixedExtentScrollController controller,
    required List<String> items,
    required int selectedValue,
    required ValueChanged<int> onSelectedItemChanged,
    required String label,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: RotatedBox(
              quarterTurns: 0,
              child: ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 50,
                perspective: 0.005,
                physics: const FixedExtentScrollPhysics(),
                diameterRatio: 1.2,
                onSelectedItemChanged: (index) {
                  onSelectedItemChanged(index); // استدعاء الدالة التي تم تمريرها
                  // بمجرد أن يختار المستخدم قيمة، قم بتحديث البيانات في AccountSetupFlow
                  final newMonth = int.parse(_months[_monthController.selectedItem]);
                  final newDay = int.parse(_days[_dayController.selectedItem]);
                  final newYear = int.parse(_years[_yearController.selectedItem]);
                  widget.onBirthdaySelected(DateTime(newYear, newMonth, newDay));
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
                          fontSize: isSelected ? 38 : 30,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                  childCount: items.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // تم إزالة SizedBox و ElevatedButton بالكامل من هنا
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'When is your birthday?',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPickerColumn(
                  controller: _monthController,
                  items: _months,
                  selectedValue: _selectedMonth,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedMonth = int.parse(_months[index]);
                    });
                  },
                  label: 'Month',
                ),
                _buildPickerColumn(
                  controller: _dayController,
                  items: _days,
                  selectedValue: _selectedDay,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedDay = int.parse(_days[index]);
                    });
                  },
                  label: 'Day',
                ),
                _buildPickerColumn(
                  controller: _yearController,
                  items: _years,
                  selectedValue: _selectedYear,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedYear = int.parse(_years[index]);
                    });
                  },
                  label: 'Year',
                ),
              ],
            ),
          ),
          // لا يوجد زر "Continue" هنا بعد الآن
        ],
      ),
    );
  }
}