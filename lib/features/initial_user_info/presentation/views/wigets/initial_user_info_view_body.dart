import 'package:az_health_care/features/initial_user_info/presentation/views/wigets/reminder_screen.dart';
import 'package:az_health_care/features/initial_user_info/presentation/views/wigets/weight_screen.dart';
import 'package:flutter/material.dart';

import 'birthday_screen.dart';
import 'height_screen.dart';


class AccountSetupFlow extends StatefulWidget {
  const AccountSetupFlow({super.key});

  @override
  State<AccountSetupFlow> createState() => _AccountSetupFlowState();
}

class _AccountSetupFlowState extends State<AccountSetupFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

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
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
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
      BirthdayScreen(
        key: const PageStorageKey('BirthdayScreen'), // إضافة مفتاح فريد
        onBirthdaySelected: _updateBirthday,
      ),
      WeightScreen(
        key: const PageStorageKey('WeightScreen'), // إضافة مفتاح فريد
        onWeightSelected: _updateWeight,
      ),
      HeightScreen(
        key: const PageStorageKey('HeightScreen'), // إضافة مفتاح فريد
        onHeightSelected: _updateHeight,
      ),
      ReminderScreen(
        key: const PageStorageKey('ReminderScreen'), // إضافة مفتاح فريد
        onReminderTimeSelected: _updateReminderTime,
      ),
      _CompletionScreen(
        key: const PageStorageKey('CompletionScreen'), // إضافة مفتاح فريد
        birthday: _selectedBirthday,
        weight: _selectedWeight,
        weightUnit: _weightUnit,
        height: _selectedHeight,
        heightUnit: _heightUnit,
        reminderTime: _selectedReminderTime,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = _getScreens();

    String buttonText = (_currentPage == pages.length - 1) ? 'Finish' : 'Continue';

    return Scaffold(
      appBar: AppBar(
        leading: _currentPage > 0 && _currentPage < pages.length - 1
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / pages.length,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              minHeight: 4,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              // أزل هذا السطر لتجربة ما إذا كان يساعد في حل المشكلة، أو أعده إذا كان ضروريًا للسلوك
              // physics: const NeverScrollableScrollPhysics(),
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
      bottomNavigationBar: _currentPage < pages.length - 1
          ? Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _onContinueButtonPressed,
            child: Text(buttonText),
          ),
        ),
      )
          : null,
    );
  }
}

// _CompletionScreen (No changes needed here unless it's the source of a GlobalKey)
class _CompletionScreen extends StatelessWidget {
  final DateTime? birthday;
  final double? weight;
  final String? weightUnit;
  final double? height;
  final String? heightUnit;
  final TimeOfDay? reminderTime;

  const _CompletionScreen({
    super.key, // تأكد من وجود super.key هنا
    this.birthday,
    this.weight,
    this.weightUnit,
    this.height,
    this.heightUnit,
    this.reminderTime,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تهانينا! اكتمل إعداد الحساب.',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text('تاريخ الميلاد: ${birthday?.toLocal().toString().split(' ')[0] ?? 'لم يتم تحديده'}'),
            Text('الوزن: ${weight?.toStringAsFixed(1) ?? 'لم يتم تحديده'} ${weightUnit ?? ''}'),
            Text('الطول: ${height?.toStringAsFixed(0) ?? 'لم يتم تحديده'} ${heightUnit ?? ''}'),
            Text('وقت التذكير: ${reminderTime?.format(context) ?? 'لم يتم تحديده'}'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                print('Back to home or restart flow');
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const AccountSetupFlow()),
                );
              },
              child: const Text('العودة للرئيسية'),
            ),
          ],
        ),
      ),
    );
  }
}