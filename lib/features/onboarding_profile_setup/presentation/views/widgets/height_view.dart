import 'package:flutter/material.dart';

class HeightView extends StatefulWidget {
  final Function(double, String) onHeightSelected;
  final double? initialHeight;
  final String initialUnit;

  const HeightView({
    super.key,
    required this.onHeightSelected,
    this.initialHeight,
    this.initialUnit = 'cm',
  });

  @override
  State<HeightView> createState() => _HeightViewState();
}

class _HeightViewState extends State<HeightView> {
  late double _selectedHeight;
  late String _selectedUnit;

  late FixedExtentScrollController _heightController;

  final List<double> _heightsCm = List.generate(151, (index) => 100.0 + index); // 100.0 to 250.0

  int _currentHeightIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedUnit = widget.initialUnit;
    _selectedHeight = widget.initialHeight ?? 170.0;

    _currentHeightIndex = _heightsCm.indexOf(_selectedHeight.roundToDouble());
    if (_currentHeightIndex == -1) {
      double closestHeight = _heightsCm.reduce((a, b) =>
      (a - _selectedHeight).abs() < (b - _selectedHeight).abs() ? a : b);
      _currentHeightIndex = _heightsCm.indexOf(closestHeight);
      _selectedHeight = closestHeight;
    }

    _heightController = FixedExtentScrollController(
      initialItem: _currentHeightIndex.clamp(0, _heightsCm.length - 1),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onHeightSelected(_selectedHeight, _selectedUnit);
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    super.dispose();
  }

  Widget _buildUnitToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildUnitButton('cm'),
          _buildUnitButton('ft'),
        ],
      ),
    );
  }

  Widget _buildUnitButton(String unit) {
    final bool isSelected = _selectedUnit == unit;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedUnit = unit;
          // عندما تتغير الوحدة، قم بإبلاغ الـ parent بالقيمة المختارة والوحدة الجديدة
          widget.onHeightSelected(_selectedHeight, _selectedUnit);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          unit.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: isSelected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }

  String _cmToFeetAndInches(double cm) {
    final double totalInches = cm / 2.54;
    final int feet = (totalInches / 12).floor();
    final double inches = (totalInches % 12);
    // تُرجع التنسيق الكامل (مثال: 5' 7.")
    return '${feet}\' ${inches.toStringAsFixed(0)}."';
  }

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 70;
    const double pickerTotalHeight = itemHeight * 7;
    final double lineVerticalPosition = (pickerTotalHeight / 2) - (itemHeight / 2) - 5;

    // تحديد عرض عمود الأرقام بناءً على الوحدة المختارة
    // لتوفير مساحة كافية لتنسيق القدم والبوصة
    double numbersColumnWidth = _selectedUnit == 'cm' ? 100 : 150;
    double linesWidth = numbersColumnWidth + 15;


    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "How tall are you?",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 40),
          Center(
            child: _buildUnitToggle(),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // الخطوط الفاصلة
                  Positioned(
                    top: lineVerticalPosition,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 160,
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
                        width: 160,
                        height: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120, // العرض المتغير لعمود الأرقام
                        height: pickerTotalHeight,
                        child: ListWheelScrollView.useDelegate(
                          controller: _heightController,
                          itemExtent: itemHeight,
                          perspective: 0.0000001,
                          physics: const FixedExtentScrollPhysics(),
                          diameterRatio: 12,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedHeight = _heightsCm[index];
                              _currentHeightIndex = index;
                              widget.onHeightSelected(_selectedHeight, _selectedUnit);
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              final double heightCm = _heightsCm[index];
                              final int distance = (index - _currentHeightIndex).abs();

                              String displayText;
                              if (_selectedUnit == 'cm') {
                                displayText = heightCm.toStringAsFixed(0);
                              } else {
                                // هنا نستخدم الدالة لتحويل وعرض القيمة بتنسيق ft/in
                                displayText = _cmToFeetAndInches(heightCm);
                              }

                              double fontSize;
                              Color textColor;

                              // تدرج حجم الخط والألوان بناءً على المسافة
                              if (distance == 0) {
                                fontSize = 50;
                                textColor = Theme.of(context).primaryColor;
                              } else if (distance == 1) {
                                fontSize = 38;
                                textColor = Colors.white70;
                              } else if (distance == 2) {
                                fontSize = 30;
                                textColor = Colors.white60;
                              } else if (distance == 3) {
                                fontSize = 25;
                                textColor = Colors.white54;
                              } else {
                                fontSize = 20;
                                textColor = Colors.white30;
                              }

                              return Center(
                                child: Text(
                                  displayText,
                                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    color: textColor,
                                    fontSize: fontSize,
                                    fontWeight: distance == 0 ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              );
                            },
                            childCount: _heightsCm.length,
                          ),
                        ),
                      ),

                      Text(
                        _selectedUnit, // عرض الوحدة المختارة (cm أو ft)
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}