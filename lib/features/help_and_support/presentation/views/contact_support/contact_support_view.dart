import 'package:az_health_care/features/help_and_support/presentation/views/contact_support/widgets/contact_support_view_body.dart';
import 'package:flutter/material.dart';

class ContactSupportView extends StatelessWidget {
  const ContactSupportView({super.key});

  static const routeName = 'contactSupportView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ContactSupportViewBody());
  }
}
