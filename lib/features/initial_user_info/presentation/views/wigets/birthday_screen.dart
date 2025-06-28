import 'package:flutter/material.dart';

class BirthdayScreen extends StatefulWidget {
  final Function(DateTime) onBirthdaySelected;
  final DateTime? initialBirthday;

  const BirthdayScreen({
    super.key,
    required this.onBirthdaySelected,
    this.initialBirthday,
  });

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  late int _selectedDay;
  late int _selectedMonth;
  late int _selectedYear;

  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _yearController;

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  List<String> _days = []; // ستحتسب ديناميكيا
  final List<String> _years = List.generate(100, (index) => (DateTime.now().year - 99 + index).toString());

  int _currentMonthIndex = 0;
  int _currentDayIndex = 0;
  int _currentYearIndex = 0;

  @override
  void initState() {
    super.initState();
    final now = widget.initialBirthday ?? DateTime.now();
    _selectedMonth = now.month;
    _selectedDay = now.day;
    _selectedYear = now.year;

    _calculateDaysInMonth();

    _currentMonthIndex = _selectedMonth - 1;
    _currentDayIndex = _selectedDay - 1;
    _currentYearIndex = _years.indexOf(_selectedYear.toString());

    _monthController = FixedExtentScrollController(
      initialItem: _currentMonthIndex.clamp(0, _months.length - 1),
    );
    _dayController = FixedExtentScrollController(
      initialItem: _currentDayIndex.clamp(0, _days.length - 1),
    );
    _yearController = FixedExtentScrollController(
      initialItem: _currentYearIndex.clamp(0, _years.length - 1),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateParentBirthday();
    });
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _calculateDaysInMonth() {
    setState(() {
      final daysInMonth = DateTime(_selectedYear, _selectedMonth + 1, 0).day;
      _days = List.generate(daysInMonth, (index) => (index + 1).toString().padLeft(2, '0'));
      if (_selectedDay > daysInMonth) {
        _selectedDay = daysInMonth;
        _currentDayIndex = _selectedDay - 1;
        if (_dayController.hasClients) {
          _dayController.jumpToItem(_currentDayIndex.clamp(0, _days.length - 1));
        }
      }
    });
  }

  void _updateParentBirthday() {
    try {
      final selectedDate = DateTime(_selectedYear, _selectedMonth, _selectedDay);
      widget.onBirthdaySelected(selectedDate);
    } catch (e) {
      print('Invalid date selected: $e');
    }
  }

  Widget _buildDatePickerColumn({
    required FixedExtentScrollController controller,
    required List<String> items,
    required int selectedIndex,
    required Function(int) onSelectedItemChangedCallback,
    required int currentScrollIndex,
    double pickerWidth = double.infinity, // إضافة خاصية عرض للـ picker
  }) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // الخط العلوي
          Positioned(
            top: 75,
            left: 0,
            right: 0,
            child: Row( // استخدم Row لعمل الخطين المنفصلين
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: pickerWidth / 2 - 20, // نصف العرض مع فاصل
                  height: 2,
                  color: Theme.of(context).primaryColor, // نفس لون الرقم المحدد
                ),
                const SizedBox(width: 40), // الفاصل بين الخطين
                Container(
                  width: pickerWidth / 2 - 20,
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          // الخط السفلي
          Positioned(
            bottom: 75,
            left: 0,
            right: 0,
            child: Row( // استخدم Row لعمل الخطين المنفصلين
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: pickerWidth / 2 - 20,
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 40),
                Container(
                  width: pickerWidth / 2 - 20,
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            width: pickerWidth, // استخدم pickerWidth هنا
            child: ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 50,
              perspective: 0.003,
              physics: const FixedExtentScrollPhysics(),
              diameterRatio: 1.5,
              onSelectedItemChanged: (index) {
                onSelectedItemChangedCallback(index);
                setState(() {
                  if (controller == _monthController) {
                    _currentMonthIndex = index;
                  } else if (controller == _dayController) {
                    _currentDayIndex = index;
                  } else if (controller == _yearController) {
                    _currentYearIndex = index;
                  }
                });
                _updateParentBirthday();
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  final item = items[index];
                  final int distance = (index - currentScrollIndex).abs();
                  double fontSize = 36;
                  Color textColor = Colors.white54;

                  if (distance == 0) {
                    fontSize = 48;
                    textColor = Theme.of(context).primaryColor;
                  } else if (distance == 1) {
                    fontSize = 36;
                    textColor = Colors.white70;
                  } else if (distance == 2) {
                    fontSize = 28;
                    textColor = Colors.white54;
                  } else {
                    fontSize = 20;
                    textColor = Colors.white30;
                  }

                  return Center(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: distance == 0 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
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
            "When is your birthday?",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDatePickerColumn(
                  controller: _monthController,
                  items: _months,
                  selectedIndex: _selectedMonth - 1,
                  onSelectedItemChangedCallback: (index) {
                    setState(() {
                      _selectedMonth = index + 1;
                      _calculateDaysInMonth();
                    });
                  },
                  currentScrollIndex: _currentMonthIndex,
                  pickerWidth: 100, // تحديد عرض لكل picker
                ),
                _buildDatePickerColumn(
                  controller: _dayController,
                  items: _days,
                  selectedIndex: _selectedDay - 1,
                  onSelectedItemChangedCallback: (index) {
                    setState(() {
                      _selectedDay = int.parse(_days[index]);
                    });
                  },
                  currentScrollIndex: _currentDayIndex,
                  pickerWidth: 100, // تحديد عرض لكل picker
                ),
                _buildDatePickerColumn(
                  controller: _yearController,
                  items: _years,
                  selectedIndex: _years.indexOf(_selectedYear.toString()),
                  onSelectedItemChangedCallback: (index) {
                    setState(() {
                      _selectedYear = int.parse(_years[index]);
                      _calculateDaysInMonth();
                    });
                  },
                  currentScrollIndex: _currentYearIndex,
                  pickerWidth: 100, // تحديد عرض لكل picker
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}