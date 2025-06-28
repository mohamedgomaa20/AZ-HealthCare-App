import 'package:az_health_care/core/widgets/custom_button.dart';
import 'package:az_health_care/features/initial_user_info/presentation/views/wigets/weight_picker_page.dart';
import 'package:flutter/material.dart';

import '../../../../personal_info/presentation/views/widgets/personal_info_view_body.dart';
import 'birthday_picker_page.dart';

class AccountSetupFlow extends StatefulWidget {
  const AccountSetupFlow({super.key});

  @override
  State<AccountSetupFlow> createState() => _AccountSetupFlowState();
}

class _AccountSetupFlowState extends State<AccountSetupFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0; // لتعقب الصفحة الحالية (لشريط التقدم)

  // بيانات المستخدم التي سيتم جمعها
  DateTime? _selectedBirthday;
  double? _selectedWeight;
  String _weightUnit = 'kg'; // الوحدة الافتراضية للوزن

  // قائمة بجميع الشاشات في التدفق
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      BirthdayScreen(
        onContinue: (date) {
          setState(() {
            _selectedBirthday = date;
            _goToNextPage();
          });
        },
      ),
      WeightScreen(
        initialWeight: _selectedWeight,
        initialUnit: _weightUnit,
        onContinue: (weight, unit) {
          setState(() {
            _selectedWeight = weight;
            _weightUnit = unit;
            _goToNextPage();
          });
        },
      ),
      // يمكن إضافة شاشات أخرى هنا بنفس النمط
      _CompletionScreen(
        birthday: _selectedBirthday,
        weight: _selectedWeight,
        weightUnit: _weightUnit,
      ), // شاشة أخيرة لعرض البيانات المجمعة
    ];
  }

  void _goToNextPage() {
    if (_currentPage < _screens.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // تم الانتهاء من جميع الخطوات، يمكن هنا إرسال البيانات
      print('Account setup completed!');
      print('Birthday: $_selectedBirthday');
      print('Weight: $_selectedWeight $_weightUnit');
      // يمكن هنا الانتقال إلى الشاشة الرئيسية للتطبيق أو إظهار رسالة نجاح
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            _currentPage > 0
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
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / _screens.length,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
              minHeight: 4,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              // لمنع التمرير اليدوي بين الصفحات
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: _screens,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(text: "Continue", onPressed: () {}),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

// شاشة بسيطة لعرض البيانات بعد الانتهاء (لغرض الاختبار)
class _CompletionScreen extends StatelessWidget {
  final DateTime? birthday;
  final double? weight;
  final String? weightUnit;

  const _CompletionScreen({this.birthday, this.weight, this.weightUnit});

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
            Text(
              'تاريخ الميلاد: ${birthday?.toLocal().toString().split(' ')[0] ?? 'لم يتم تحديده'}',
            ),
            Text(
              'الوزن: ${weight?.toStringAsFixed(1) ?? 'لم يتم تحديده'} ${weightUnit ?? ''}',
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // يمكنك إضافة منطق للعودة إلى الشاشة الرئيسية أو إعادة تشغيل التدفق
                print('Back to home or restart flow');
              },
              child: const Text('العودة للرئيسية'),
            ),
          ],
        ),
      ),
    );
  }
}
