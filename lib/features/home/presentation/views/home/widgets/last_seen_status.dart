import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:az_health_care/core/utils/app_text_styles.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastSeenStatus extends StatefulWidget {
  const LastSeenStatus({super.key});

  @override
  State<LastSeenStatus> createState() => _LastSeenStatusState();
}

class _LastSeenStatusState extends State<LastSeenStatus> {
  bool isOnline = false;
  DateTime? lastSeen;

  @override
  void initState() {
    super.initState();
    checkConnectivity();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      bool connected = result != ConnectivityResult.none;
      setState(() {
        isOnline = connected;
        if (connected) {
          lastSeen = DateTime.now();
        }
      });
    });
  }

  Future<void> checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    bool connected = result != ConnectivityResult.none;
    setState(() {
      isOnline = connected;
      if (connected) {
        lastSeen = DateTime.now();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 85,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    isOnline ? AppColors.greenColor : AppColors.redColor,
                radius: 6,
              ),
              const SizedBox(width: 6),
              Text(
                isOnline ? 'Online' : 'Offline',
                style: AppTextStyles.medium14,
              ),
            ],
          ),
        ),
        // if (!isOnline)
        if (!isOnline && lastSeen != null)
          Text(
            "Last: ${DateFormat.jm().format(lastSeen!)}",
            style: AppTextStyles.medium14,
          )
        else
          const SizedBox(height: 20),
      ],
    );
  }
}
