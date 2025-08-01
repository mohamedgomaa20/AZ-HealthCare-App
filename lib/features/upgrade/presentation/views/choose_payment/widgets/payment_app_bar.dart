import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  final Widget? trailingWidget;

  const CustomAppBar({
    super.key,
    required this.title,
     this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 24),
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (trailingWidget!=null)
            trailingWidget!
          else
            SizedBox(width: 40),
        ],
      ),
    );
  }
}
