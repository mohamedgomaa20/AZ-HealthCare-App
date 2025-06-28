import 'package:az_health_care/core/constants.dart';
import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/wigets/reminder_screen.dart';
import 'package:az_health_care/features/onboarding_profile_setup/presentation/views/wigets/weight_screen.dart';
import 'package:flutter/material.dart';

import 'birthday_screen.dart';
import 'creating_account_dialog_loading.dart';
import 'gender_screen.dart';
import 'height_screen.dart';

class AccountSetupFlow extends StatefulWidget {
  const AccountSetupFlow({super.key});

  static const String routeName = "accountSetupFlow";

  @override
  State<AccountSetupFlow> createState() => _AccountSetupFlowState();
}

class _AccountSetupFlowState extends State<AccountSetupFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Gender? _selectedGender;

  DateTime? _selectedBirthday;
  double? _selectedWeight;
  String _weightUnit = 'kg';
  double? _selectedHeight;
  String _heightUnit = 'cm';
  TimeOfDay? _selectedReminderTime;

  void _updateBirthday(DateTime date) {
    setState(() {
      _selectedBirthday = date;
    });
  }

  void _updateGender(Gender gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  void _updateWeight(double weight, String unit) {
    setState(() {
      _selectedWeight = weight;
      _weightUnit = unit;
    });
  }

  void _updateHeight(double height, String unit) {
    setState(() {
      _selectedHeight = height;
      _heightUnit = unit;
    });
  }

  void _updateReminderTime(TimeOfDay time) {
    setState(() {
      _selectedReminderTime = time;
    });
  }

  void _onContinueButtonPressed() {
    if (_currentPage < _getScreens().length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      print('Account setup completed!');
      print('Birthday: $_selectedBirthday');
      print('Weight: $_selectedWeight $_weightUnit');
      print('Height: $_selectedHeight $_heightUnit');
      print('Reminder Time: $_selectedReminderTime');
      // بما أنك تعود لـ AccountSetupFlow، تأكد من إعادة تعيين الحالة أو إدارتها بشكل صحيح
      // إذا كان هذا هو الزر الأخير، فقد ترغب في الانتقال إلى شاشة رئيسية مختلفة بدلاً من إعادة تشغيل Flow
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (_) => const Text("Home Screen Placeholder"),
      //   ), // Placeholder
      // );
      showDialog(
        context: context,
        barrierDismissible: false,
        // <--- مهم: يمنع إغلاق الـ dialog بالضغط خارجها
        builder: (BuildContext context) {
          return const CreatingAccountDialogLoading(); // الـ dialog الذي أنشأناه
        },
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _getScreens() {
    return [
      // 1. شاشة تحديد الجنس (وضعناها هنا كأول شاشة منطقية بعد الترحيب)
      GenderScreen(
        key: const PageStorageKey('GenderScreen'),
        // مفتاح لتخزين الحالة (مهم لـ PageView)
        onGenderSelected: _updateGender,
        // دالة الكولباك لاستقبال القيمة
        initialGender: _selectedGender,
        // تمرير القيمة الأولية (إذا كنت تريد استعادة الاختيار)
      ),
      BirthdayScreen(
        key: const PageStorageKey('BirthdayScreen'),
        onBirthdaySelected: _updateBirthday,
        initialBirthday: _selectedBirthday, // <--- **هذا هو السطر المهم**
      ),
      WeightScreen(
        key: const PageStorageKey('WeightScreen'),
        onWeightSelected: _updateWeight,
      ),
      HeightScreen(
        key: const PageStorageKey('HeightScreen'),
        onHeightSelected: _updateHeight,
      ),
      ReminderScreen(
        key: const PageStorageKey('ReminderScreen'),
        onReminderTimeSelected: _updateReminderTime,
      ),
      // _CompletionScreen(
      //   key: const PageStorageKey('CompletionScreen'),
      //   birthday: _selectedBirthday,
      //   weight: _selectedWeight,
      //   weightUnit: _weightUnit,
      //   height: _selectedHeight,
      //   heightUnit: _heightUnit,
      //   reminderTime: _selectedReminderTime,
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = _getScreens();

    String buttonText =
        (_currentPage == pages.length - 1) ? 'Finish' : 'Continue';

    return Scaffold(
      appBar: AppBar(
        leading:
            _currentPage > 0 && _currentPage < pages.length - 1
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                )
                : null,
        title: Row(
          children: [
            SizedBox(width: 10),
            Expanded(
              // <--- نضع شريط التقدم داخل Expanded ليمتد ويسمح بوجود Text بجانبه
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / pages.length,
                backgroundColor: Colors.white12,
                color: Theme.of(context).primaryColor,

                minHeight: 10,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(width: 40),
            Text(
              '${_currentPage + 1} / ${pages.length}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white, // لون النص
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
               onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          _currentPage < pages.length
              ? SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: kHorizontalPadding,
                        right: kHorizontalPadding,
                        bottom: kHorizontalPadding,
                        top: 16,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: buttonText,
                          onPressed: _onContinueButtonPressed,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : null,
    );
  }
}

// _CompletionScreen (No changes needed here unless it's the source of a GlobalKey)
// class _CompletionScreen extends StatelessWidget {
//   final DateTime? birthday;
//   final double? weight;
//   final String? weightUnit;
//   final double? height;
//   final String? heightUnit;
//   final TimeOfDay? reminderTime;
//
//   const _CompletionScreen({
//     super.key,
//     this.birthday,
//     this.weight,
//     this.weightUnit,
//     this.height,
//     this.heightUnit,
//     this.reminderTime,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'تهانينا! اكتمل إعداد الحساب.',
//               style: Theme.of(context).textTheme.headlineMedium,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Setup Complete!',
//               style: Theme.of(
//                 context,
//               ).textTheme.headlineMedium?.copyWith(color: Colors.white),
//             ),
//             const SizedBox(height: 20),
//             // Text(
//             //   'Gender: ${gender?.toString().split('.').last ?? 'Not set'}',
//             //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
//             // ),
//             Text(
//               'Birthday: ${birthday != null ? '${birthday!.month}/${birthday!.day}/${birthday!.year}' : 'Not set'}',
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
//             ),
//             Text(
//               'Weight: ${weight != null ? '$weight $weightUnit' : 'Not set'}',
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
//             ),
//             Text(
//               'Height: ${height != null ? '$height $heightUnit' : 'Not set'}',
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
//             ),
//             Text(
//               'Reminder: ${reminderTime != null ? reminderTime!.format(context) : 'Not set'}',
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
//             ),
//             const SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () {
//                 print('Back to home or restart flow');
//                 // تغيير هذا السطر للانتقال إلى الشاشة الرئيسية الفعلية لتطبيقك
//                 // وليس إعادة تشغيل الـ AccountSetupFlow
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(
//                     builder: (_) => const Text("Home Screen Placeholder"),
//                   ), // مثال
//                 );
//               },
//               child: const Text('العودة للرئيسية'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
