  import 'package:az_health_care/features/Auth/presentation/views/complete_information/widgets/complete_information_body.dart';
import 'package:flutter/material.dart';

class CompleteInformationView extends StatelessWidget {
  const CompleteInformationView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : CompleteInformationBody(),
    );
  }
}