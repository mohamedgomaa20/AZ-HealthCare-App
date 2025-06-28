import 'package:flutter/material.dart';

class BirthdayScreen extends StatefulWidget {
  final Function(DateTime) onContinue;

  const BirthdayScreen({super.key, required this.onContinue});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  // القيم الافتراضية
  int _selectedMonth = DateTime.now().month;
  int _selectedDay = DateTime.now().day;
  int _selectedYear = DateTime.now().year - 20; // افتراضي: 20 سنة قبل الآن

  final FixedExtentScrollController _monthController = FixedExtentScrollController();
  final FixedExtentScrollController _dayController = FixedExtentScrollController();
  final FixedExtentScrollController _yearController = FixedExtentScrollController();

  // قائمة الأشهر (يمكن استخدام DateFormat للأسماء)
  final List<String> _months = List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));
  final List<String> _days = List.generate(31, (index) => (index + 1).toString().padLeft(2, '0'));
  final List<String> _years = List.generate(100, (index) => (DateTime.now().year - index).toString());

  @override
  void initState() {
    super.initState();
    // ضبط الـ controllers للقيم الافتراضية
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
            height: 200, // ارتفاع الـ picker
            child: RotatedBox(
              quarterTurns: 0, // لا تدوير، للحفاظ على الاتجاه
              child: ListWheelScrollView.useDelegate(
                controller: controller,
                itemExtent: 50, // ارتفاع كل عنصر
                perspective: 0.005, // تأثير المنظور
                physics: const FixedExtentScrollPhysics(),
                diameterRatio: 1.2, // لتضييق أو توسيع الدائرة
                onSelectedItemChanged: onSelectedItemChanged,
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    final item = items[index % items.length]; // لضمان التكرار إذا أردت
                    final isSelected = item == selectedValue.toString().padLeft(2, '0') || item == selectedValue.toString();
                    return Center(
                      child: Text(
                        item,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: isSelected ? Theme.of(context).primaryColor : Colors.white54,
                          fontSize: isSelected ? 38 : 30, // تكبير النص المحدد
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
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final birthday = DateTime(_selectedYear, _selectedMonth, _selectedDay);
                widget.onContinue(birthday);
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
// class BirthdayScreen extends StatefulWidget {
//   @override
//   _BirthdayScreenState createState() => _BirthdayScreenState();
// }
//
// class _BirthdayScreenState extends State<BirthdayScreen> {
//   final TextEditingController _monthController = TextEditingController(text: '09');
//   final TextEditingController _dayController = TextEditingController(text: '22');
//   final TextEditingController _yearController = TextEditingController(text: '1992');
//
//   List<Map<String, String>> dateOptions = [
//     {'month': '10', 'day': '23', 'year': '1993'},
//     {'month': '11', 'day': '24', 'year': '1994'},
//     {'month': '12', 'day': '25', 'year': '1995'},
//     {'month': '01', 'day': '26', 'year': '1996'},
//     {'month': '02', 'day': '27', 'year': '1997'},
//     {'month': '03', 'day': '28', 'year': '1998'},
//   ];
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
//                 'When is your birthday?',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 30),
//
//               // Table with text fields
//               Table(
//                 border: TableBorder.all(
//                   color: Colors.grey[300]!,
//                   width: 1.0,
//                 ),
//                 columnWidths: {
//                   0: FlexColumnWidth(1),
//                   1: FlexColumnWidth(1),
//                   2: FlexColumnWidth(1.5),
//                 },
//                 children: [
//                   TableRow(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                     ),
//                     children: [
//                       TableCell(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12.0),
//                           child: Text(
//                             'Month',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12.0),
//                           child: Text(
//                             'Day',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12.0),
//                           child: Text(
//                             'Year',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   TableRow(
//                     children: [
//                       TableCell(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextField(
//                             controller: _monthController,
//                             textAlign: TextAlign.center,
//                             maxLength: 2,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               counterText: '',
//                               border: OutlineInputBorder(),
//                               contentPadding: EdgeInsets.symmetric(vertical: 8),
//                             ),
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextField(
//                             controller: _dayController,
//                             textAlign: TextAlign.center,
//                             maxLength: 2,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               counterText: '',
//                               border: OutlineInputBorder(),
//                               contentPadding: EdgeInsets.symmetric(vertical: 8),
//                             ),
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextField(
//                             controller: _yearController,
//                             textAlign: TextAlign.center,
//                             maxLength: 4,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               counterText: '',
//                               border: OutlineInputBorder(),
//                               contentPadding: EdgeInsets.symmetric(vertical: 8),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//
//               // Date options
//               Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 alignment: WrapAlignment.center,
//                 children: dateOptions.map((date) {
//                   bool isSelected = _monthController.text == date['month'] &&
//                       _dayController.text == date['day'] &&
//                       _yearController.text == date['year'];
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _monthController.text = date['month']!;
//                         _dayController.text = date['day']!;
//                         _yearController.text = date['year']!;
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
//                         '${date['month']} ${date['day']} ${date['year']}',
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
//                       Navigator.pushNamed(context, '/weight');
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
//
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// // class BirthdayPickerPage extends StatefulWidget {
// //   const BirthdayPickerPage({super.key});
// //
// //   @override
// //   State<BirthdayPickerPage> createState() => _BirthdayPickerPageState();
// // }
// //
// // class _BirthdayPickerPageState extends State<BirthdayPickerPage> {
// //   int selectedMonth = 12;
// //   int selectedDay = 25;
// //   int selectedYear = 1995;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       appBar: AppBar(
// //         backgroundColor: Colors.black,
// //         elevation: 0,
// //         leading: const BackButton(color: Colors.white),
// //         title: const Text(
// //           "3 / 6",
// //           style: TextStyle(color: Colors.white),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: Column(
// //         children: [
// //           const SizedBox(height: 16),
// //           const Text(
// //             "When is your birthday?",
// //             style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
// //           ),
// //           const SizedBox(height: 16),
// //           Expanded(
// //             child: CupertinoPicker(
// //               backgroundColor: Colors.black,
// //               itemExtent: 40,
// //               scrollController: FixedExtentScrollController(initialItem: 11),
// //               onSelectedItemChanged: (value) {
// //                 setState(() => selectedMonth = value + 1);
// //               },
// //               children: List.generate(12, (i) => Center(child: Text("${i + 1}".padLeft(2, '0'), style: const TextStyle(color: Colors.white)))),
// //             ),
// //           ),
// //           Expanded(
// //             child: CupertinoPicker(
// //               backgroundColor: Colors.black,
// //               itemExtent: 40,
// //               scrollController: FixedExtentScrollController(initialItem: 24),
// //               onSelectedItemChanged: (value) {
// //                 setState(() => selectedDay = value + 1);
// //               },
// //               children: List.generate(31, (i) => Center(child: Text("${i + 1}".padLeft(2, '0'), style: const TextStyle(color: Colors.white)))),
// //             ),
// //           ),
// //           Expanded(
// //             child: CupertinoPicker(
// //               backgroundColor: Colors.black,
// //               itemExtent: 40,
// //               scrollController: FixedExtentScrollController(initialItem: 3),
// //               onSelectedItemChanged: (value) {
// //                 setState(() => selectedYear = 1992 + value);
// //               },
// //               children: List.generate(35, (i) => Center(child: Text("${1992 + i}", style: const TextStyle(color: Colors.white)))),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(20),
// //             child: ElevatedButton(
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.red,
// //                 minimumSize: const Size(double.infinity, 50),
// //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
// //               ),
// //               onPressed: () {
// //                 print("Selected: $selectedDay/$selectedMonth/$selectedYear");
// //               },
// //               child: const Text("Continue", style: TextStyle(fontSize: 16)),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
