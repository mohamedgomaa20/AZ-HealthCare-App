import 'package:flutter/material.dart';

class WeightScreen extends StatefulWidget {
  final Function(double, String) onWeightSelected;
  final double? initialWeight;
  final String initialUnit;

  const WeightScreen({
    super.key,
    required this.onWeightSelected,
    this.initialWeight,
    this.initialUnit = 'kg',
  });

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  late double _selectedWeight;
  late String _selectedUnit;

  final FixedExtentScrollController _weightController = FixedExtentScrollController();

  final List<double> _weights = List.generate(200, (index) => 20.0 + index);

  @override
  void initState() {
    super.initState();
    _selectedUnit = widget.initialUnit;
    _selectedWeight = widget.initialWeight ?? 70.0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      int initialIndex = _weights.indexOf(_selectedWeight);
      if (initialIndex != -1) {
        _weightController.jumpToItem(initialIndex);
      }
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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What's your body weight?",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 40),
          Center(
            child: _buildUnitToggle(),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: Row( // استخدم Row لاحتواء الـ picker والوحدة
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  SizedBox(
                    width: 150, // لتحديد عرض الـ picker
                    height: 200,
                    child: ListWheelScrollView.useDelegate(
                      controller: _weightController,
                      itemExtent: 50,
                      perspective: 0.005,
                      physics: const FixedExtentScrollPhysics(),
                      diameterRatio: 1.2,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedWeight = _weights[index];
                          widget.onWeightSelected(_selectedWeight, _selectedUnit);
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          final item = _weights[index].toStringAsFixed(0);
                          final isSelected = _weights[index] == _selectedWeight;
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
                        childCount: _weights.length,
                      ),
                    ),
                  ),
                  // الوحدة الثابتة
                  const SizedBox(width: 10), // مسافة بين الرقم والوحدة
                  Text(
                    _selectedUnit, // عرض الوحدة المختارة
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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