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

  // تغيير الشهور لتكون أرقامًا
  final List<String> _months = List.generate(
    12,
        (index) => (index + 1).toString().padLeft(2, '0'),
  ); // 01, 02, ..., 12

  List<String> _days = [];
  final List<String> _years = List.generate(
    100,
        (index) => (DateTime.now().year - 99 + index).toString(),
  );

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
      _days = List.generate(
        daysInMonth,
            (index) => (index + 1).toString().padLeft(2, '0'),
      );
      if (_selectedDay > daysInMonth) {
        _selectedDay = daysInMonth;
        _currentDayIndex = _selectedDay - 1;
        if (_dayController.hasClients) {
          _dayController.jumpToItem(
            _currentDayIndex.clamp(0, _days.length - 1),
          );
        }
      }
    });
  }

  void _updateParentBirthday() {
    try {
      final selectedDate = DateTime(
        _selectedYear,
        _selectedMonth,
        _selectedDay,
      );
      widget.onBirthdaySelected(selectedDate);
    } catch (e) {
      print('Invalid date selected: $e');
    }
  }

  Widget _buildDatePickerColumn({
    required FixedExtentScrollController controller,
    required List<String> items,
    required Function(int) onSelectedItemChangedCallback,
    required int currentScrollIndex,
    required double pickerWidth,
  }) {
    // زيادة ارتفاع كل عنصر لزيادة المسافة بينه وبين الذي يليه، خاصة حول العنصر المركزي
    const double itemHeight = 70; // زيادة أكبر لـ itemExtent

    // تحديد الارتفاع الكلي للـ SizedBox لاستيعاب 7 عناصر بمسافات أكبر
    // (7 عناصر * itemHeight)
    const double pickerTotalHeight = itemHeight * 7;

    // إعادة حساب موضع الخطوط الفاصلة
    // (الارتفاع الكلي / 2) - (ارتفاع العنصر / 2)
    final double lineVerticalPosition = (pickerTotalHeight / 2) - (itemHeight / 2)-5;

    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
           Positioned(
            top: lineVerticalPosition,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: pickerWidth + 15,
                height: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
           Positioned(
            bottom: lineVerticalPosition,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: pickerWidth + 15,
                height: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: pickerTotalHeight, // ارتفاع أعلى ليتسع لـ 7 أرقام بمسافات أكبر
            width: pickerWidth,
            child: ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: itemHeight, // ارتفاع كل عنصر
              perspective: 0.0000001, // تقليل المنظور بشكل أكبر
              physics: const FixedExtentScrollPhysics(),
              diameterRatio: 12, // قيمة أصغر جداً لجعلها شبه مسطحة (قد تحتاج للتجربة هنا)
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
                  double fontSize;
                  Color textColor;

                  // تدرج دقيق لحجم الخط والألوان لـ 7 عناصر مرئية
                  if (distance == 0) {
                    fontSize = 50; // الحجم الأساسي للرقم المحدد
                    textColor = Theme.of(context).primaryColor;
                  } else if (distance == 1) {
                    fontSize = 38; // أقرب رقم (1 بعيد عن المحدد)
                    textColor = Colors.white70;
                  } else if (distance == 2) {
                    fontSize = 30; // الرقم الثاني (2 بعيد عن المحدد)
                    textColor = Colors.white60;
                  } else if (distance == 3) {
                    fontSize = 25; // الرقم الثالث (3 بعيد عن المحدد)
                    textColor = Colors.white54;
                  } else {
                    fontSize = 20; // الأرقام الأبعد (الرابع والخامس وهكذا)
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  onSelectedItemChangedCallback: (index) {
                    setState(() {
                      _selectedMonth = int.parse(_months[index]);
                      _calculateDaysInMonth();
                    });
                  },
                  currentScrollIndex: _currentMonthIndex,
                  pickerWidth: 80,
                ),
                _buildDatePickerColumn(
                  controller: _dayController,
                  items: _days,
                  onSelectedItemChangedCallback: (index) {
                    setState(() {
                      _selectedDay = int.parse(_days[index]);
                    });
                  },
                  currentScrollIndex: _currentDayIndex,
                  pickerWidth: 80,
                ),
                _buildDatePickerColumn(
                  controller: _yearController,
                  items: _years,
                  onSelectedItemChangedCallback: (index) {
                    setState(() {
                      _selectedYear = int.parse(_years[index]);
                      _calculateDaysInMonth();
                    });
                  },
                  currentScrollIndex: _currentYearIndex,
                  pickerWidth: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}