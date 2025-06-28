import 'package:flutter/material.dart';

import '../../../../../core/constants.dart';

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

  final List<String> _hours = List.generate(
    12,
        (index) => (index + 1).toString().padLeft(2, '0'),
  ); // 01-12
  final List<String> _minutes = List.generate(
    60,
        (index) => index.toString().padLeft(2, '0'),
  ); // 00-59

  // متغيرات جديدة لتتبع العنصر المحدد حالياً في ListWheelScrollView لأغراض التنسيق البصري
  int _currentHourIndex = 0;
  int _currentMinuteIndex = 0;

  @override
  void initState() {
    super.initState();

    final now = widget.initialTime ?? TimeOfDay.now();

    _selectedHour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    _selectedMinute = now.minute;
    _selectedAmPm = now.period == DayPeriod.am ? 'AM' : 'PM';

    // تحديد الـ index الأولي للعنصر المختار
    _currentHourIndex = _hours.indexOf(
      _selectedHour.toString().padLeft(2, '0'),
    );
    _currentMinuteIndex = _minutes.indexOf(
      _selectedMinute.toString().padLeft(2, '0'),
    );

    // التأكد من أن الـ index الأولي ضمن النطاق الصحيح
    _currentHourIndex = _currentHourIndex.clamp(0, _hours.length - 1);
    _currentMinuteIndex = _currentMinuteIndex.clamp(0, _minutes.length - 1);

    _hourController = FixedExtentScrollController(
      initialItem: _currentHourIndex,
    );
    _minuteController = FixedExtentScrollController(
      initialItem: _currentMinuteIndex,
    );

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

  // تم تعديل هذه الدالة لتطبيق التنسيقات المطلوبة
  Widget _buildTimePickerColumn({
    required FixedExtentScrollController controller,
    required List<String> items,
    required int currentScrollIndex, // نضيفها لنتحكم في التنسيق
    required ValueChanged<int> onSelectedItemChanged,
    required double pickerWidth, // لضبط عرض الخطوط
  }) {
    // نفس الثوابت التي استخدمناها في HeightScreen
    const double itemHeight = 70; // ارتفاع كل عنصر
    const double pickerTotalHeight = itemHeight * 7; // الارتفاع الكلي للعجلة (7 عناصر مرئية)
    // موضع الخطوط الفاصلة (منتصف ارتفاع العجلة - نصف ارتفاع العنصر - ضبط يدوي)
    final double lineVerticalPosition = (pickerTotalHeight / 2) - (itemHeight / 2)-5 ;

    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // الخط العلوي
          Positioned(
            top: lineVerticalPosition,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 150, // عرض الخط
                height: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          // الخط السفلي
          Positioned(
            bottom: lineVerticalPosition,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 150, // عرض الخط
                height: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: pickerTotalHeight, // ارتفاع يتسع لـ 7 عناصر
            width: pickerWidth, // عرض العمود
            child: ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: itemHeight, // ارتفاع كل عنصر
              perspective: 0.0000001, // قيمة صغيرة جداً لتقليل المنظور (جعلها مسطحة)
              physics: const FixedExtentScrollPhysics(),
              diameterRatio: 12, // قيمة كبيرة جداً لجعلها شبه مسطحة
              onSelectedItemChanged: (index) {
                // نحدث الـ index المحلي أولاً ثم نبلغ الـ parent
                onSelectedItemChanged(index);
                _updateParentTime();
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  final item = items[index];
                  // حساب المسافة من العنصر المركزي لضبط التنسيق
                  final int distance = (index - currentScrollIndex).abs();

                  double fontSize;
                  Color textColor;

                  // تدرج حجم الخط والألوان بناءً على المسافة
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
                    fontSize = 20; // الأرقام الأبعد
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

  Widget _buildAmPmToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [_buildAmPmButton('AM'), _buildAmPmButton('PM')],
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
          color:
          isSelected ? Theme.of(context).primaryColor : Colors.transparent,
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
      padding: const EdgeInsets.only(top: kHorizontalPadding, left: kHorizontalPadding, right: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "When would you like to\nreceive health check reminders?",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 20),
          Center(child: _buildAmPmToggle()),
          const SizedBox(height: 20),

          Expanded(
            child: Center(
              child: SizedBox(
                width: 250, // زيادة العرض لاستيعاب العمودين (ساعات ودقائق) وعلامة الفاصل

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     _buildTimePickerColumn(
                      controller: _hourController,
                      items: _hours,
                      currentScrollIndex: _currentHourIndex, // تمرير الـ index الحالي
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedHour = int.parse(_hours[index]);
                          _currentHourIndex = index; // تحديث الـ index الحالي
                        });
                      },
                      pickerWidth: 80, // عرض عمود الساعات
                    ),
                    Text(
                      ':',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 48,
                      ),
                    ),
                    // عمود الدقائق
                    _buildTimePickerColumn(
                      controller: _minuteController,
                      items: _minutes,
                      currentScrollIndex: _currentMinuteIndex, // تمرير الـ index الحالي
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedMinute = int.parse(_minutes[index]);
                          _currentMinuteIndex = index; // تحديث الـ index الحالي
                        });
                      },
                      pickerWidth: 80, // عرض عمود الدقائق
                    ),
                  ],
                ),
              ),
            ),
          ),


          Center(
            child: Text(
              'You can always change this later.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }
}