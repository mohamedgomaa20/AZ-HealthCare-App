import 'package:flutter/material.dart';
import '../../../../../upgrade/presentation/views/choose_payment/widgets/payment_app_bar.dart';
import 'contact_support_options_list.dart';

class ContactSupportViewBody extends StatelessWidget {
  const ContactSupportViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: const [
          CustomAppBar(title: 'Contact Support'),
          SizedBox(height: 15),
          Expanded(child: ContactSupportOptionsList()),
        ],
      ),
    );
  }
}
