import 'package:flutter/cupertino.dart';

import 'faq_question_tile.dart';

class FAQQuestionList extends StatelessWidget {
  final String category;
  final String searchText;

  const FAQQuestionList({
    super.key,
    required this.category,
    required this.searchText,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, String>>> questionsMap = {
      'General': [
        {
          'question': 'What is A2Z Care?',
          'answer':
              'A2Z Care is a health app that helps you monitor vital signs like heart rate, blood pressure, and glucose.',
        },
        {
          'question': 'How does A2Z Care work?',
          'answer':
              'It uses AI and sensors to collect, analyze, and track your health data in real-time.',
        },
        {
          'question': 'Is A2Z Care suitable for all ages?',
          'answer':
              'Yes, it is designed to be used by people of all ages with customizable settings.',
        },
        {
          'question': 'Can I use A2Z Care for my family?',
          'answer':
              'Yes, you can create multiple profiles and track health for each family member.',
        },
        {
          'question': 'Does A2Z Care require an internet connection?',
          'answer':
              'It works offline but syncs data when the internet is available.',
        },
      ],

      'Account': [
        {
          'question': 'How do I create an account?',
          'answer':
              'You can sign up with your email and a password or use Google/Apple login.',
        },
        {
          'question': 'I forgot my password, what do I do?',
          'answer':
              'Use the "Forgot Password" link on the login screen to reset it via email.',
        },
        {
          'question': 'Can I change my email address?',
          'answer': 'Yes, go to Settings > Account and choose "Change Email".',
        },
        {
          'question': 'How do I delete my account?',
          'answer':
              'Visit Account Settings and tap "Delete Account" at the bottom.',
        },
        {
          'question': 'Is email verification required?',
          'answer':
              'Yes, verifying your email is required to access all features.',
        },
      ],

      'Services': [
        {
          'question': 'What services does A2Z Care offer?',
          'answer':
              'Health tracking, medication reminders, daily health tips, and premium AI analysis.',
        },
        {
          'question': 'Are all services free?',
          'answer':
              'Basic features are free. Premium services like AI diagnostics require a subscription.',
        },
        {
          'question': 'What is included in the premium plan?',
          'answer':
              'Unlimited tracking, in-depth reports, and priority customer support.',
        },
        {
          'question': 'Can I cancel my subscription anytime?',
          'answer': 'Yes, you can cancel from your account settings.',
        },
        {
          'question': 'Do you provide health consultations?',
          'answer':
              'We partner with licensed professionals for online consultations (Premium only).',
        },
      ],

      'Tracking': [
        {
          'question': 'What can I track using A2Z Care?',
          'answer':
              'Heart rate, blood pressure, blood sugar, oxygen levels, sleep, and activity.',
        },
        {
          'question': 'How often should I track my vitals?',
          'answer':
              'We recommend daily checks, especially for users with chronic conditions.',
        },
        {
          'question': 'Can I export my health tracking data?',
          'answer':
              'Yes, data can be exported as CSV or PDF from the settings.',
        },
        {
          'question': 'Does A2Z Care support syncing with smartwatches?',
          'answer':
              'Yes, we support major wearables like Fitbit, Apple Watch, and Wear OS.',
        },
        {
          'question': 'Can I set tracking reminders?',
          'answer':
              'Yes, you can set daily or weekly reminders in the Reminder settings.',
        },
      ],

      'General2': [
        {
          'question': 'Is A2Z Care medically approved?',
          'answer':
              'Our app follows healthcare standards and collaborates with certified professionals.',
        },
        {
          'question': 'Is the app available globally?',
          'answer': 'Yes, you can download and use the app in most countries.',
        },
        {
          'question': 'Does A2Z Care work in dark mode?',
          'answer': 'Yes, it supports both light and dark modes.',
        },
        {
          'question': 'Can I customize the dashboard?',
          'answer': 'Yes, widgets and display sections are fully customizable.',
        },
        {
          'question': 'How often is the app updated?',
          'answer':
              'We release updates monthly to ensure new features and security.',
        },
      ],
      'Account2': [
        {
          'question': 'Can I use A2Z Care on multiple devices?',
          'answer':
              'Yes, just log in with the same account and your data will sync.',
        },
        {
          'question': 'What data is stored on my account?',
          'answer':
              'Your vitals, progress history, reminders, and preferences.',
        },
        {
          'question': 'Is my data private and secure?',
          'answer':
              'Absolutely. We use end-to-end encryption and comply with GDPR.',
        },
        {
          'question': 'Can I back up my account data?',
          'answer': 'Yes, backups are automatic if you enable cloud sync.',
        },
        {
          'question': 'How do I contact support about account issues?',
          'answer':
              'Use the in-app support chat or email us from Settings > Help.',
        },
      ],
    };

    final allQuestions = questionsMap[category] ?? [];
    final filteredQuestions =
        allQuestions.where((q) {
          final query = searchText.toLowerCase();
          return q['question']!.toLowerCase().contains(query) ||
              q['answer']!.toLowerCase().contains(query);
        }).toList();

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      itemCount: filteredQuestions.length,
      itemBuilder: (context, index) {
        return FAQQuestionTile(
          question: filteredQuestions[index]['question']!,
          answer: filteredQuestions[index]['answer']!,
        );
      },
    );
  }
}
