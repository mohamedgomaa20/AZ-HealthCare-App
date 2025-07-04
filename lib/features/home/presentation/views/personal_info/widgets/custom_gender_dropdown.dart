//  import 'package:flutter/material.dart';
//
// import '../personal_info_cubit/personal_info_cubit.dart';
//
// class CustomDropdownGenderField extends StatelessWidget {
//   const CustomDropdownGenderField({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = PersonalInfoCubit.get(context);
//     return DropdownButtonFormField<String>(
//       value: cubit.selectedGender,
//       items: ['Male', 'Female', 'Other']
//           .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//           .toList(),
//       onChanged: (value) {
//         if (value != null) cubit.changeGender(value);
//       },
//     );
//   }
// }
