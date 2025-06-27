 import 'package:flutter/material.dart';


class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: Text("DateTime"),
            onPressed: () {
              print(DateTime.now().toString());
            },
          ),
        ],
      ),
    );
  }
}
