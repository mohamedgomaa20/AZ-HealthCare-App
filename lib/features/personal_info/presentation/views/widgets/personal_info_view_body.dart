// A Flutter version of the full Personal Info Onboarding Flow
 import 'package:flutter/material.dart';
class PersonalInfoOnBoarding extends StatelessWidget {
  const PersonalInfoOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const NameScreen();
  }
}

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenContent(
      title: "What's your name?",
      progress: 0.16,
      child: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Name',
            ),
          ),
          const SizedBox(height: 16),
          ContinueButton(
            enabled: nameController.text.isNotEmpty,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const GenderScreen()));
            },
          )
        ],
      ),
    );
  }
}

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return ScreenContent(
      title: "What's your gender?",
      progress: 0.32,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GenderOption(
                label: 'Male',
                selected: selectedGender == 'Male',
                onTap: () => setState(() => selectedGender = 'Male'),
              ),
              GenderOption(
                label: 'Female',
                selected: selectedGender == 'Female',
                onTap: () => setState(() => selectedGender = 'Female'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ContinueButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const BirthdayScreen()));
          })
        ],
      ),
    );
  }
}

class BirthdayScreen extends StatelessWidget {
  const BirthdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContent(
      title: "When is your birthday?",
      progress: 0.48,
      child: Column(
        children: [
          const Text("(Use your own DatePicker or Pickers)"),
          const SizedBox(height: 16),
          ContinueButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WeightScreen())),
          )
        ],
      ),
    );
  }
}

class WeightScreen extends StatelessWidget {
  const WeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContent(
      title: "What's your body weight?",
      progress: 0.64,
      child: Column(
        children: [
          const Text("(Use NumberPicker plugin or your own)"),
          const SizedBox(height: 16),
          ContinueButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HeightScreen())),
          )
        ],
      ),
    );
  }
}

class HeightScreen extends StatelessWidget {
  const HeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContent(
      title: "How tall are you?",
      progress: 0.8,
      child: Column(
        children: [
          const Text("(Use NumberPicker plugin or your own)"),
          const SizedBox(height: 16),
          ContinueButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RemindersScreen())),
          )
        ],
      ),
    );
  }
}

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenContent(
      title: "Health check reminders?",
      progress: 0.96,
      child: Column(
        children: [
          const Text("(Time Picker / Custom Input Here)"),
          const SizedBox(height: 16),
          ContinueButton(
            text: 'Finish',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoadingScreen())),
          )
        ],
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(color: Colors.red),
            SizedBox(height: 16),
            Text("Creating your account...", style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}

class ScreenContent extends StatelessWidget {
  final String title;
  final double progress;
  final Widget child;

  const ScreenContent({super.key, required this.title, required this.progress, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LinearProgressIndicator(value: progress, color: Colors.red),
            const SizedBox(height: 32),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 22)),
            const SizedBox(height: 32),
            child
          ],
        ),
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;
  final String text;

  const ContinueButton({super.key, required this.onPressed, this.enabled = true, this.text = 'Continue'});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}

class GenderOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const GenderOption({super.key, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: selected ? Colors.red : Colors.grey,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              label[0],
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.red : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
//
// class PersonalInfoViewBody extends StatefulWidget {
//   const PersonalInfoViewBody({super.key});
//
//   @override
//   State<PersonalInfoViewBody> createState() => _PersonalInfoViewBodyState();
// }
//
// class _PersonalInfoViewBodyState extends State<PersonalInfoViewBody> {
//   String selectedGender = 'Male';
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // العنوان
//           Text(
//             "What's your gender?",
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//
//           const SizedBox(height: 32),
//
//           // اختيارات الجنس
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               GenderOption(
//                 text: 'Male',
//                 selected: selectedGender == 'Male',
//                 onTap: () {
//                   setState(() {
//                     selectedGender = 'Male';
//                   });
//                 },
//               ),
//               GenderOption(
//                 text: 'Female',
//                 selected: selectedGender == 'Female',
//                 onTap: () {
//                   setState(() {
//                     selectedGender = 'Female';
//                   });
//                 },
//               ),
//             ],
//           ),
//
//           const Spacer(),
//
//           // زر الاستمرار
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/birthday');
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text(
//                 "Continue",
//                 style: TextStyle(fontSize: 16, color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class GenderOption extends StatelessWidget {
//   final String text;
//   final bool selected;
//   final VoidCallback onTap;
//
//   const GenderOption({
//     super.key,
//     required this.text,
//     required this.selected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(50),
//       child: Column(
//         children: [
//           Container(
//             height: 64,
//             width: 64,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: selected ? Colors.red : Colors.grey,
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               text[0],
//               style: const TextStyle(color: Colors.white, fontSize: 24),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             text,
//             style: TextStyle(
//               color: selected ? Colors.red : Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
