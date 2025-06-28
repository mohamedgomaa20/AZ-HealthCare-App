import 'package:flutter/material.dart';

class WeightView extends StatefulWidget {
  final Function(double, String) onWeightSelected;
  final double? initialWeight;
  final String initialUnit;

  const WeightView({
    super.key,
    required this.onWeightSelected,
    this.initialWeight,
    this.initialUnit = 'kg',
  });

  @override
  State<WeightView> createState() => _WeightViewState();
}

class _WeightViewState extends State<WeightView> {
  late double _selectedWeight;
  late String _selectedUnit;

  late FixedExtentScrollController _weightController; // استخدم late

  // توليد قائمة الأوزان
  // يمكنك تغيير النطاق حسب الحاجة، مثلاً من 20 إلى 200
  final List<double> _weights = List.generate(200, (index) => 20.0 + index);

  // لتتبع العنصر المحدد حاليا في الـ ListWheelScrollView
  int _currentWeightIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedUnit = widget.initialUnit;
    _selectedWeight = widget.initialWeight ?? 70.0; // قيمة افتراضية للوزن

    // حساب الـ index الأولي
    _currentWeightIndex = _weights.indexOf(_selectedWeight.roundToDouble());
    // إذا لم يتم العثور على الوزن بالضبط، ابحث عن أقرب وزن أو اضبط قيمة افتراضية
    if (_currentWeightIndex == -1) {
      // إذا لم يتم العحديد، قم بتعيين أول عنصر أو قيمة قريبة
      _selectedWeight = _weights[0]; // أو ابحث عن أقرب قيمة
      _currentWeightIndex = 0;
    }


    _weightController = FixedExtentScrollController(
      initialItem: _currentWeightIndex.clamp(0, _weights.length - 1),
    );


    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onWeightSelected(_selectedWeight, _selectedUnit);
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
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
          _buildUnitButton('kg'),
          _buildUnitButton('lb'),
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
          widget.onWeightSelected(_selectedWeight, _selectedUnit);
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

  @override
  Widget build(BuildContext context) {
    // نفس قيم itemHeight و pickerTotalHeight من BirthdayScreen
    const double itemHeight = 70;
    const double pickerTotalHeight = itemHeight * 7;
    // موضع الخطوط الفاصلة
    final double lineVerticalPosition = (pickerTotalHeight / 2) - (itemHeight / 2) - 5;


    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "What's your body weight?",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 40),
          Center(
            child: _buildUnitToggle(),
          ),
          const SizedBox(height: 20), // إضافة مسافة بين التوغل والعجلة

          Expanded(
            child: Center(
              child: Stack( // استخدم Stack لوضع الخطوط
                alignment: Alignment.center,
                children: [
                  // الخط العلوي
                  Positioned(
                    top: lineVerticalPosition,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 150, // عرض العمود + مسافة إضافية
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
                        width: 150, // عرض العمود + مسافة إضافية
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
                        width: 100, // عرض عمود الأرقام
                        height: pickerTotalHeight, // ارتفاع يتسع لـ 7 عناصر
                        child: ListWheelScrollView.useDelegate(
                          controller: _weightController,
                          itemExtent: itemHeight, // نفس ارتفاع العنصر
                          perspective: 0.0000001, // نفس المنظور القليل جدا
                          physics: const FixedExtentScrollPhysics(),
                          diameterRatio: 12, // نفس نسبة القطر الكبيرة جدا
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedWeight = _weights[index];
                              _currentWeightIndex = index; // تحديث الاندكس الحالي
                              widget.onWeightSelected(_selectedWeight, _selectedUnit);
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              final item = _weights[index].toStringAsFixed(0); // عرض بدون كسور
                              final int distance = (index - _currentWeightIndex).abs(); // المسافة من العنصر المركزي

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
                                  item,
                                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    color: textColor,
                                    fontSize: fontSize,
                                    fontWeight: distance == 0 ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              );
                            },
                            childCount: _weights.length,
                          ),
                        ),
                      ),

                      Text(
                        _selectedUnit, // عرض الوحدة المختارة
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24, // حجم أكبر للوحدة
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