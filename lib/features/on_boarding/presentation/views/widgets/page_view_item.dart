 import 'package:flutter/material.dart';

 import '../../../domain/models/boarding_model.dart';


class PageViewItem extends StatelessWidget {
  final BoardingModel model;

  const PageViewItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 150),
          Image.asset(model.image, width: double.infinity, height: 250),
          SizedBox(height: 50),
          Text(
            textAlign: TextAlign.center,
            model.title,
            style: TextStyle(
              fontSize: 23,
               fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Text(
            textAlign: TextAlign.center,
            model.body,
            style: TextStyle(fontSize: 17, color: Colors.grey

              // ,fontStyle: FontStyle.italic
            ),
          ),
        ],
      ),
    );
  }
}
