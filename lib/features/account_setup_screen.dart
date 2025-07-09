import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AccountSetupScreen extends StatefulWidget {
  const AccountSetupScreen({super.key});

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final TextEditingController _nameController = TextEditingController();
  String? _selectedGender;
  DateTime? _selectedDate;
  double? _weight;
  double? _height;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildNamePage(),
      _buildGenderPage(),
      _buildBirthdayPage(),
      _buildWeightPage(),
      _buildHeightPage(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading:
            _currentPage > 0
                ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed:
                      () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                )
                : null,
        title: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .55,
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(10),

              value: (_currentPage + 1) / _pages.length,
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
              minHeight: 12,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              "${_currentPage + 1} / ${_pages.length}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],

        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: const Color(0xFF121212),
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          if (_currentPage < _pages.length - 1) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            // Submit manager here
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Text(
          _currentPage == _pages.length - 1 ? 'Finish' : 'Continue',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildNamePage() {
    return _buildPage(
      title: "What's your name?",
      child: TextField(
        controller: _nameController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Andrew',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }


  Widget _buildGenderPage() {
    return _buildPage(
      title: "What's your gender?",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            ['Male', 'Female'].map((gender) {
              final isSelected = _selectedGender == gender;
              return GestureDetector(
                onTap: () => setState(() => _selectedGender = gender),
                child: Column(
                  children: [
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.red : Colors.grey[700],
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        gender == 'Male' ? Icons.male : Icons.female,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      gender,
                      style: TextStyle(
                        color: isSelected ? Colors.red : Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildBirthdayPage() {
    return _buildPage(
      title: "When is your birthday?",
      child: SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: _selectedDate ?? DateTime(1995, 12, 25),
          maximumDate: DateTime.now(),
          onDateTimeChanged:
              (newDate) => setState(() => _selectedDate = newDate),
        ),
      ),
    );
  }

  Widget _buildWeightPage() {
    return _buildPage(
      title: "What's your body weight?",
      child: SizedBox(
        height: 200,
        child: CupertinoPicker(
          itemExtent: 40,
          onSelectedItemChanged:
              (index) => setState(() => _weight = 40.0 + index),
          children: List.generate(
            150,
            (index) => Center(
              child: Text(
                '${40 + index} kg',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeightPage() {
    return _buildPage(
      title: "How tall are you?",
      child: SizedBox(
        height: 200,
        child: CupertinoPicker(
          itemExtent: 40,
          onSelectedItemChanged:
              (index) => setState(() => _height = 140.0 + index),
          children: List.generate(
            100,
            (index) => Center(
              child: Text(
                '${140 + index} cm',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 32),
          child,
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
// class AccountSetupScreen extends StatefulWidget {
//   const AccountSetupScreen({super.key});
//
//   @override
//   State<AccountSetupScreen> createState() => _AccountSetupScreenState();
// }
//
// class _AccountSetupScreenState extends State<AccountSetupScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   final TextEditingController _nameController = TextEditingController();
//   String? _selectedGender;
//   DateTime? _selectedDate;
//   double? _weight;
//   double? _height;
//
//   final List<Widget> _pages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _pages.addAll([
//       _buildNamePage(),
//       _buildGenderPage(),
//       _buildBirthdayPage(),
//       _buildWeightPage(),
//       _buildHeightPage(),
//     ]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF121212),
//         elevation: 0,
//         leading: _currentPage > 0
//             ? IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => _pageController.previousPage(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//           ),
//         )
//             : null,
//         title: Text(
//           "${_currentPage + 1} / ${_pages.length}",
//           style: const TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(4),
//           child: _buildProgressBar(),
//         ),
//       ),
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         onPageChanged: (index) => setState(() => _currentPage = index),
//         children: _pages,
//       ),
//       bottomNavigationBar: _buildBottomBar(),
//     );
//   }
//
//   Widget _buildProgressBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: List.generate(_pages.length, (index) {
//           return AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             margin: const EdgeInsets.symmetric(horizontal: 4),
//             height: 4,
//             width: index == _currentPage ? 40 : 10,
//             decoration: BoxDecoration(
//               color: index <= _currentPage ? Colors.red : Colors.grey[700],
//               borderRadius: BorderRadius.circular(10),
//             ),
//           );
//         }),
//       ),
//     );
//   }
//
//   Widget _buildBottomBar() {
//     return Container(
//       color: const Color(0xFF121212),
//       padding: const EdgeInsets.all(16),
//       child: ElevatedButton(
//         onPressed: () {
//           if (_currentPage < _pages.length - 1) {
//             _pageController.nextPage(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//             );
//           } else {
//             // Submit manager here
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.red,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//         ),
//         child: Text(
//           _currentPage == _pages.length - 1 ? 'Finish' : 'Continue',
//           style: const TextStyle(color: Colors.white, fontSize: 16),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNamePage() {
//     return _buildPage(
//       title: "What's your name?",
//       child: TextField(
//         controller: _nameController,
//         style: const TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           hintText: 'Andrew',
//           hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.red),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGenderPage() {
//     return _buildPage(
//       title: "What's your gender?",
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: ['Male', 'Female'].map((gender) {
//           final isSelected = _selectedGender == gender;
//           return GestureDetector(
//             onTap: () => setState(() => _selectedGender = gender),
//             child: Column(
//               children: [
//                 Container(
//                   height: 64,
//                   width: 64,
//                   decoration: BoxDecoration(
//                     color: isSelected ? Colors.red : Colors.grey[700],
//                     shape: BoxShape.circle,
//                   ),
//                   alignment: Alignment.center,
//                   child: Icon(
//                     gender == 'Male' ? Icons.male : Icons.female,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   gender,
//                   style: TextStyle(color: isSelected ? Colors.red : Colors.white),
//                 )
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildBirthdayPage() {
//     return _buildPage(
//       title: "When is your birthday?",
//       child: SizedBox(
//         height: 200,
//         child: CupertinoDatePicker(
//           mode: CupertinoDatePickerMode.date,
//           initialDateTime: _selectedDate ?? DateTime(1995, 12, 25),
//           maximumDate: DateTime.now(),
//           onDateTimeChanged: (newDate) => setState(() => _selectedDate = newDate),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildWeightPage() {
//     return _buildPage(
//       title: "What's your body weight?",
//       child: SizedBox(
//         height: 200,
//         child: CupertinoPicker(
//           itemExtent: 40,
//           onSelectedItemChanged: (index) => setState(() => _weight = 40.0 + index),
//           children: List.generate(150, (index) => Center(
//             child: Text('${40 + index} kg', style: const TextStyle(color: Colors.white)),
//           )),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeightPage() {
//     return _buildPage(
//       title: "How tall are you?",
//       child: SizedBox(
//         height: 200,
//         child: CupertinoPicker(
//           itemExtent: 40,
//           onSelectedItemChanged: (index) => setState(() => _height = 140.0 + index),
//           children: List.generate(100, (index) => Center(
//             child: Text('${140 + index} cm', style: const TextStyle(color: Colors.white)),
//           )),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPage({required String title, required Widget child}) {
//     return Padding(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: const TextStyle(color: Colors.white, fontSize: 24)),
//           const SizedBox(height: 32),
//           child,
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
// class AccountSetupScreen extends StatefulWidget {
//   const AccountSetupScreen({super.key});
//
//   @override
//   State<AccountSetupScreen> createState() => _AccountSetupScreenState();
// }
//
// class _AccountSetupScreenState extends State<AccountSetupScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;
//   final TextEditingController _nameController = TextEditingController();
//   String? _selectedGender;
//   DateTime? _selectedDate;
//   double? _weight;
//   double? _height;
//
//   final List<Widget> _pages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _pages.addAll([
//       _buildNamePage(),
//       _buildGenderPage(),
//       _buildBirthdayPage(),
//       _buildWeightPage(),
//       _buildHeightPage(),
//     ]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         title: Text(
//           'Dark_account setup step ${_currentPage + 1}...',
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//       body: PageView(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         onPageChanged: (index) => setState(() => _currentPage = index),
//         children: _pages,
//       ),
//       bottomNavigationBar: _buildBottomBar(),
//     );
//   }
//
//   Widget _buildBottomBar() {
//     return Container(
//       color: Colors.black,
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           if (_currentPage > 0)
//             TextButton(
//               onPressed: () => _pageController.previousPage(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//               ),
//               child: const Text('BACK', style: TextStyle(color: Colors.blue)),
//             ),
//           TextButton(
//             onPressed: () {
//               if (_currentPage < _pages.length - 1) {
//                 _pageController.nextPage(
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeInOut,
//                 );
//               } else {
//                 // Submit manager here
//               }
//             },
//             child: Text(
//               _currentPage == _pages.length - 1 ? 'FINISH' : 'NEXT',
//               style: const TextStyle(color: Colors.blue),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNamePage() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "What's your name?",
//             style: TextStyle(color: Colors.white, fontSize: 24),
//           ),
//           const SizedBox(height: 32),
//           TextField(
//             controller: _nameController,
//             style: const TextStyle(color: Colors.white),
//             decoration: const InputDecoration(
//               hintText: 'Enter your name',
//               hintStyle: TextStyle(color: Colors.grey),
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildGenderPage() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "What's your gender?",
//             style: TextStyle(color: Colors.white, fontSize: 24),
//           ),
//           const SizedBox(height: 32),
//           Column(
//             children: [
//               RadioListTile<String>(
//                 title: const Text('Male', style: TextStyle(color: Colors.white)),
//                 value: 'Male',
//                 groupValue: _selectedGender,
//                 onChanged: (value) => setState(() => _selectedGender = value),
//               ),
//               RadioListTile<String>(
//                 title: const Text('Female', style: TextStyle(color: Colors.white)),
//                 value: 'Female',
//                 groupValue: _selectedGender,
//                 onChanged: (value) => setState(() => _selectedGender = value),
//               ),
//               RadioListTile<String>(
//                 title: const Text('Other', style: TextStyle(color: Colors.white)),
//                 value: 'Other',
//                 groupValue: _selectedGender,
//                 onChanged: (value) => setState(() => _selectedGender = value),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBirthdayPage() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "When is your birthday?",
//             style: TextStyle(color: Colors.white, fontSize: 24),
//           ),
//           const SizedBox(height: 32),
//           SizedBox(
//             height: 200,
//             child: CupertinoDatePicker(
//               mode: CupertinoDatePickerMode.date,
//               initialDateTime: _selectedDate ?? DateTime(1990),
//               maximumDate: DateTime.now(),
//               onDateTimeChanged: (DateTime newDate) {
//                 setState(() => _selectedDate = newDate);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildWeightPage() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "What's your body weight?",
//             style: TextStyle(color: Colors.white, fontSize: 24),
//           ),
//           const SizedBox(height: 32),
//           SizedBox(
//             height: 200,
//             child: CupertinoPicker(
//               itemExtent: 40,
//               onSelectedItemChanged: (index) {
//                 setState(() => _weight = 40.0 + index);
//               },
//               children: List.generate(150, (index) {
//                 return Center(
//                   child: Text(
//                     '${40 + index} kg',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildHeightPage() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "How tall are you?",
//             style: TextStyle(color: Colors.white, fontSize: 24),
//           ),
//           const SizedBox(height: 32),
//           SizedBox(
//             height: 200,
//             child: CupertinoPicker(
//               itemExtent: 40,
//               onSelectedItemChanged: (index) {
//                 setState(() => _height = 140.0 + index);
//               },
//               children: List.generate(80, (index) {
//                 return Center(
//                   child: Text(
//                     '${140 + index} cm',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
// class AccountSetupScreen extends StatefulWidget {
//   const AccountSetupScreen({super.key});
//
//   @override
//   State<AccountSetupScreen> createState() => _AccountSetupScreenState();
// }
//
// class _AccountSetupScreenState extends State<AccountSetupScreen> {
//   int _currentStep = 0;
//   final TextEditingController _nameController = TextEditingController();
//   String? _selectedGender;
//   DateTime? _selectedDate;
//   double? _weight;
//   double? _height;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         title: Text(
//           'Dark_account setup step ${_currentStep + 1}...',
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Theme(
//         data: ThemeData.dark().copyWith(
//           colorScheme: const ColorScheme.dark(
//             primary: Colors.blueAccent,
//             surface: Colors.black,
//           ),
//         ),
//         child: Stepper(
//           currentStep: _currentStep,
//           onStepContinue: () {
//             if (_currentStep < 4) {
//               setState(() => _currentStep += 1);
//             }
//           },
//           onStepCancel: () {
//             if (_currentStep > 0) {
//               setState(() => _currentStep -= 1);
//             }
//           },
//           steps: [
//             _buildNameStep(),
//             _buildGenderStep(),
//             _buildBirthdayStep(),
//             _buildWeightStep(),
//             _buildHeightStep(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Step _buildNameStep() {
//     return Step(
//       title: const Text("What's your name?"),
//       content: TextField(
//         controller: _nameController,
//         style: const TextStyle(color: Colors.white),
//         decoration: const InputDecoration(
//           hintText: 'Enter your name',
//           hintStyle: TextStyle(color: Colors.grey),
//         ),
//       ),
//     );
//   }
//
//   Step _buildGenderStep() {
//     return Step(
//       title: const Text("What's your gender?"),
//       content: Column(
//         children: [
//           ListTile(
//             title: const Text('Male', style: TextStyle(color: Colors.white)),
//             leading: Radio<String>(
//               value: 'Male',
//               groupValue: _selectedGender,
//               onChanged: (value) {
//                 setState(() => _selectedGender = value);
//               },
//             ),
//           ),
//           ListTile(
//             title: const Text('Female', style: TextStyle(color: Colors.white)),
//             leading: Radio<String>(
//               value: 'Female',
//               groupValue: _selectedGender,
//               onChanged: (value) {
//                 setState(() => _selectedGender = value);
//               },
//             ),
//           ),
//           ListTile(
//             title: const Text('Other', style: TextStyle(color: Colors.white)),
//             leading: Radio<String>(
//               value: 'Other',
//               groupValue: _selectedGender,
//               onChanged: (value) {
//                 setState(() => _selectedGender = value);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Step _buildBirthdayStep() {
//     return Step(
//       title: const Text("When is your birthday?"),
//       content: Column(
//         children: [
//           SizedBox(
//             height: 200,
//             child: CupertinoDatePicker(
//               mode: CupertinoDatePickerMode.date,
//               initialDateTime: DateTime(1990),
//               maximumDate: DateTime.now(),
//               onDateTimeChanged: (DateTime newDate) {
//                 setState(() => _selectedDate = newDate);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Step _buildWeightStep() {
//     return Step(
//       title: const Text("What's your body weight?"),
//       content: SizedBox(
//         height: 200,
//         child: CupertinoPicker(
//           itemExtent: 40,
//           onSelectedItemChanged: (index) {
//             setState(() => _weight = 40.0 + index);
//           },
//           children: List.generate(150, (index) {
//             return Center(
//               child: Text(
//                 '${40 + index} kg',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
//
//   Step _buildHeightStep() {
//     return Step(
//       title: const Text("How tall are you?"),
//       content: SizedBox(
//         height: 200,
//         child: CupertinoPicker(
//           itemExtent: 40,
//           onSelectedItemChanged: (index) {
//             setState(() => _height = 140.0 + index);
//           },
//           children: List.generate(80, (index) {
//             return Center(
//               child: Text(
//                 '${140 + index} cm',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
