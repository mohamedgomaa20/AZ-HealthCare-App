import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';

class VolumeSlider extends StatelessWidget {
  final double value;
  final Function(double) onChanged;

  const VolumeSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(CupertinoIcons.volume_off, color: AppColors.white54Color, size: 20),
            onPressed: () => onChanged(0),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 6,
                activeTrackColor: AppColors.primaryColor,
                inactiveTrackColor: AppColors.white10Color,
                thumbColor: AppColors.primaryColor,
                overlayColor: AppColors.primaryColor.withOpacity(0.2),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
              ),
              child: Slider(
                value: value,
                onChanged: onChanged,
                min: 0.0,
                max: 1.0,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.volume_up, color: AppColors.white54Color,size: 20),
            onPressed: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// class VolumeSlider extends StatelessWidget {
//   final double volumeLevel;
//   final ValueChanged<double> onChanged;
//
//   const VolumeSlider({
//     super.key,
//     required this.volumeLevel,
//     required this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       child: Row(
//         children: [
//           const Icon(Icons.volume_off, color: Color(0xFF999999), size: 20),
//           const SizedBox(width: 16),
//           Expanded(
//             child: SliderTheme(
//               data: SliderThemeData(
//                 trackHeight: 3,
//                 activeTrackColor: const Color(0xFFFF4757),
//                 inactiveTrackColor: const Color(0xFF333333),
//                 thumbColor: const Color(0xFFFF4757),
//                 overlayColor: const Color(0xFFFF4757).withOpacity(0.2),
//                 thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
//                 overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
//               ),
//               child: Slider(
//                 value: volumeLevel,
//                 onChanged: onChanged,
//                 min: 0.0,
//                 max: 1.0,
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           const Icon(Icons.volume_up, color: Color(0xFF999999), size: 20),
//         ],
//       ),
//     );
//   }
// }
