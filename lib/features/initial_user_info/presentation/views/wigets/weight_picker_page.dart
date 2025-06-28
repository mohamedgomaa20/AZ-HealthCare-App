import 'package:flutter/material.dart';

class WeightScreen extends StatefulWidget {
  final Function(double, String) onContinue;
  final double? initialWeight;
  final String initialUnit;

  const WeightScreen({
    super.key,
    required this.onContinue,
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

  // قائمة الأوزان (يمكن توسيع النطاق حسب الحاجة)
  final List<double> _weights = List.generate(200, (index) => 20.0 + index); // من 20 كجم إلى 219 كجم

  @override
  void initState() {
    super.initState();
    _selectedUnit = widget.initialUnit;
    _selectedWeight = widget.initialWeight ?? 70.0; // وزن افتراضي

    // ضبط الـ controller للوزن الافتراضي
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int initialIndex = _weights.indexOf(_selectedWeight);
      if (initialIndex != -1) {
        _weightController.jumpToItem(initialIndex);
      }
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
        color: Colors.grey[800], // خلفية خفيفة لمحدد الوحدة
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
          // يمكنك إضافة منطق لتحويل الوزن عند تغيير الوحدة هنا
          // على سبيل المثال: if (_selectedUnit == 'lb' && unit == 'kg') { _selectedWeight = _selectedWeight * 0.453592; }
          // ولكن هذا سيتطلب إعادة حساب الـ index للـ picker
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
              child: SizedBox(
                height: 200, // ارتفاع الـ picker
                child: ListWheelScrollView.useDelegate(
                  controller: _weightController,
                  itemExtent: 50, // ارتفاع كل عنصر
                  perspective: 0.005, // تأثير المنظور
                  physics: const FixedExtentScrollPhysics(),
                  diameterRatio: 1.2,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedWeight = _weights[index];
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final item = _weights[index].toStringAsFixed(0); // إظهار كعدد صحيح
                      final isSelected = _weights[index] == _selectedWeight;
                      return Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              item,
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: isSelected ? Theme.of(context).primaryColor : Colors.white54,
                                fontSize: isSelected ? 48 : 36, // تكبير النص المحدد
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            if (isSelected) // عرض الوحدة فقط عند التحديد
                              Text(
                                ' $_selectedUnit',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                    childCount: _weights.length,
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
                widget.onContinue(_selectedWeight, _selectedUnit);
              },
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class WeightScreen extends StatefulWidget {
//   final Function(double, String) onContinue; // هذه هي المشكلة
//   final double? initialWeight; // هذه هي المشكلة
//   final String initialUnit; // هذه هي المشكلة
//
//   const WeightScreen({ // هذا هو الحل!
//     super.key,
//     required this.onContinue,
//     this.initialWeight,
//     this.initialUnit = 'kg',
//   });
//
//   @override
//   _WeightScreenState createState() => _WeightScreenState();
// }
//
// class _WeightScreenState extends State<WeightScreen> {
//   bool _isKg = true;
//   int _selectedWeight = 76;
//
//   List<int> weightOptions = [73, 74, 75, 76, 77, 78, 79];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 "What's your body weight?",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 30),
//
//               // Unit toggle
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _isKg = true;
//                       });
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(
//                             color: _isKg ? Colors.blue : Colors.transparent,
//                             width: 2,
//                           ),
//                         ),
//                       ),
//                       child: Text(
//                         'kg',
//                         style: TextStyle(
//                           color: _isKg ? Colors.blue : Colors.grey,
//                           fontWeight: _isKg ? FontWeight.bold : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 20),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _isKg = false;
//                       });
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(
//                             color: !_isKg ? Colors.blue : Colors.transparent,
//                             width: 2,
//                           ),
//                         ),
//                       ),
//                       child: Text(
//                         'lb',
//                         style: TextStyle(
//                           color: !_isKg ? Colors.blue : Colors.grey,
//                           fontWeight: !_isKg ? FontWeight.bold : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//
//               // Weight options
//               Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 alignment: WrapAlignment.center,
//                 children: weightOptions.map((weight) {
//                   bool isSelected = _selectedWeight == weight;
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _selectedWeight = weight;
//                       });
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: isSelected ? Colors.blue : Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: isSelected ? Colors.blue : Colors.grey[300]!,
//                         ),
//                       ),
//                       child: Text(
//                         '$weight${_isKg ? ' kg' : ' lb'}',
//                         style: TextStyle(
//                           color: isSelected ? Colors.white : Colors.black87,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               Spacer(),
//
//               // Continue button
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border(top: BorderSide(color: Colors.grey[300]!)),
//                 ),
//                 padding: EdgeInsets.only(top: 16),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                     onPressed: () {
//                       // Handle continue action
//                     },
//                     child: Text(
//                       'Continue',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class WeightPickerPage extends StatefulWidget {
//   const WeightPickerPage({super.key});
//
//   @override
//   State<WeightPickerPage> createState() => _WeightPickerPageState();
// }
//
// class _WeightPickerPageState extends State<WeightPickerPage> {
//   bool isKg = true;
//   int selectedWeight = 76;
//
//   List<int> kgWeights = List.generate(121, (index) => 30 + index); // 30 - 150
//   List<int> lbWeights = List.generate(121, (index) => ((30 + index) * 2.2).round());
//
//   @override
//   Widget build(BuildContext context) {
//     final weightList = isKg ? kgWeights : lbWeights;
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         leading: const BackButton(color: Colors.white),
//         title: const Text("4 / 6", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 16),
//           const Text(
//             "What’s your body weight?",
//             style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ToggleButtons(
//                 isSelected: [isKg, !isKg],
//                 onPressed: (index) => setState(() => isKg = index == 0),
//                 borderRadius: BorderRadius.circular(20),
//                 selectedColor: Colors.white,
//                 fillColor: Colors.red,
//                 color: Colors.white60,
//                 children: const [
//                   Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text("kg")),
//                   Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text("lb")),
//                 ],
//               ),
//             ],
//           ),
//           Expanded(
//             child: CupertinoPicker(
//               itemExtent: 40,
//               backgroundColor: Colors.black,
//               scrollController: FixedExtentScrollController(initialItem: weightList.indexOf(76)),
//               onSelectedItemChanged: (index) {
//                 setState(() => selectedWeight = weightList[index]);
//               },
//               children: weightList.map((w) => Center(child: Text("$w", style: const TextStyle(color: Colors.white)))).toList(),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 minimumSize: const Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//               ),
//               onPressed: () {
//                 print("Selected Weight: $selectedWeight ${isKg ? 'kg' : 'lb'}");
//               },
//               child: const Text("Continue", style: TextStyle(fontSize: 16)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
