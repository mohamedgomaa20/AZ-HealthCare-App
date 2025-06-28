import 'package:flutter/material.dart';

class HeightScreen extends StatefulWidget {
  final Function(double, String) onHeightSelected;
  final double? initialHeight;
  final String initialUnit;

  const HeightScreen({
    super.key,
    required this.onHeightSelected,
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

  final List<double> _heightsCm = List.generate(150, (index) => 100.0 + index);

  @override
  void initState() {
    super.initState();
    _selectedUnit = widget.initialUnit;
    _selectedHeight = widget.initialHeight ?? 170.0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      int initialIndex = _heightsCm.indexOf(_selectedHeight);
      if (initialIndex != -1) {
        _heightController.jumpToItem(initialIndex);
      }
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
    return '${feet}\' ${inches.toStringAsFixed(0)}."';
  }

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  SizedBox(
                    width: 120,
                    height: 300,
                    child: ListWheelScrollView.useDelegate(
                      controller: _heightController,
                      itemExtent: 50,
                      perspective: 0.005,
                      physics: const FixedExtentScrollPhysics(),
                      diameterRatio: 1.2,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedHeight = _heightsCm[index];
                          widget.onHeightSelected(_selectedHeight, _selectedUnit);
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
                            child: Text(
                              displayText,
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: isSelected ? Theme.of(context).primaryColor : Colors.white54,
                                fontSize: isSelected ? 48 : 36,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                        childCount: _heightsCm.length,
                      ),
                    ),
                  ),
                    if (_selectedUnit == 'cm')
                    Text(
                      _selectedUnit,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  // لا نعرض 'ft' هنا لأنها جزء من _cmToFeetAndInches
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}