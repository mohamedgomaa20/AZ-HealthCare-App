import 'package:flutter/material.dart';

class TopBox extends StatelessWidget {
  final String text;

  TopBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3700B3), Color(0xFF6200EE)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(65),
          bottomRight: Radius.circular(65),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'Serif',
            ),
          ),
        ],
      ),
    );
  }
}
