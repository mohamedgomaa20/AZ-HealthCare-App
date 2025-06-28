import 'package:flutter/material.dart';

class HeightScreen extends StatefulWidget {
  final Function(double, String) onContinue;
  final double? initialHeight;
  final String initialUnit;

  const HeightScreen({
    super.key,
    required this.onContinue,
    this.initialHeight,
    this.initialUnit = 'cm',
  });

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  late double _selectedHeight;
  late String _selectedUnit;

  final FixedExtentScrollController _heightController = FixedExtentScrollController();

  // قائمة الأطوال (بالسنتيمتر)
  final List<double> _heightsCm = List.generate(150, (index) => 100.0 + index); // من 100 سم إلى 249 سم
  // قائمة الأطوال (بالقدم والبوصة) - تتطلب تحويلاً
  // لتسهيل الأمر، سنستخدم قائمة واحدة ونقوم بالتحويل للعرض فقط إذا كانت الوحدة ft

  @override
  void initState() {
    super.initState();
    _selectedUnit = widget.initialUnit;
    _selectedHeight = widget.initialHeight ?? 170.0; // طول افتراضي

    // ضبط الـ controller للطول الافتراضي
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int initialIndex = _heightsCm.indexOf(_selectedHeight);
      if (initialIndex != -1) {
        _heightController.jumpToItem(initialIndex);
      }
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
          // **ملاحظة: منطق التحويل من سم إلى قدم (أو العكس) لم يتم تضمينه هنا لتبسيط المثال.**
          // إذا كنت تريد تحويل القيمة الفعلية للطول عند التبديل،
          // ستحتاج إلى تطبيق منطق التحويل وإعادة حساب فهرس الـ picker.
          // مثال بسيط للتحويل (يحتاج إلى تحسين):
          // if (unit == 'ft' && _selectedUnit == 'cm') {
          //   _selectedHeight = _selectedHeight / 30.48; // cm to feet
          // } else if (unit == 'cm' && _selectedUnit == 'ft') {
          //   _selectedHeight = _selectedHeight * 30.48; // feet to cm
          // }
          // ثم قم بتحديث _heightController.jumpToItem() للقيمة الجديدة.
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

  // دالة مساعدة لتحويل السنتيمتر إلى قدم وبوصة للعرض
  String _cmToFeetAndInches(double cm) {
    final double totalInches = cm / 2.54;
    final int feet = (totalInches / 12).floor();
    final double inches = (totalInches % 12);
    return '${feet}\' ${inches.toStringAsFixed(0)}."'; // 5' 11."
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How tall are you?",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 40),
          Center(
            child: _buildUnitToggle(),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: SizedBox(
                height: 200,
                child: ListWheelScrollView.useDelegate(
                  controller: _heightController,
                  itemExtent: 50,
                  perspective: 0.005,
                  physics: const FixedExtentScrollPhysics(),
                  diameterRatio: 1.2,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedHeight = _heightsCm[index];
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final double heightCm = _heightsCm[index];
                      final bool isSelected = heightCm == _selectedHeight;

                      String displayText;
                      if (_selectedUnit == 'cm') {
                        displayText = heightCm.toStringAsFixed(0);
                      } else {
                        displayText = _cmToFeetAndInches(heightCm);
                      }

                      return Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              displayText,
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: isSelected ? Theme.of(context).primaryColor : Colors.white54,
                                fontSize: isSelected ? 48 : 36,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            if (isSelected && _selectedUnit == 'cm')
                              Text(
                                ' cm',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            // لا نضيف "ft" هنا لأنها جزء من _cmToFeetAndInches
                          ],
                        ),
                      );
                    },
                    childCount: _heightsCm.length,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onContinue(_selectedHeight, _selectedUnit);
              },
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}