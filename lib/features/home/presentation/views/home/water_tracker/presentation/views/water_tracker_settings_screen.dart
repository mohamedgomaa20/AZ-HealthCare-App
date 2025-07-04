 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/water_tracking_cubit.dart';
import '../cubit/water_tracking_state.dart';

class WaterTrackerSettingsScreen extends StatefulWidget {
  const WaterTrackerSettingsScreen({super.key});

  @override
  State<WaterTrackerSettingsScreen> createState() => _WaterTrackerSettingsScreenState();
}

class _WaterTrackerSettingsScreenState extends State<WaterTrackerSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  int _reminderInterval = 60; // minutes
  String _selectedUnit = 'ml';
  TimeOfDay _startTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 22, minute: 0);

  final List<String> _units = ['ml', 'oz', 'cups'];
  final List<int> _reminderIntervals = [30, 60, 90, 120, 180];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
      surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFF161B22),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<WaterTrackingCubit, WaterTrackingState>(
        builder: (context, state) {
          if (state is WaterTrackingLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildGoalSection(state),
                  _buildNotificationsSection(),
                  _buildUnitsSection(),
                  _buildReminderSection(),
                  _buildDataSection(),
                  _buildAboutSection(),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D4FF)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGoalSection(WaterTrackingLoaded state) {
    return _buildSectionCard(
      title: 'Daily Goal',
      icon: Icons.flag,
      children: [
        _buildSettingTile(
          icon: Icons.local_drink,
          title: 'Target Amount',
          subtitle: '${state.goal.targetAmount}ml',
          trailing: const Icon(Icons.edit, color: Color(0xFF00D4FF)),
          onTap: () => _showGoalBottomSheet(context, state.goal.targetAmount),
        ),
        _buildSettingTile(
          icon: Icons.trending_up,
          title: 'Progress Today',
          subtitle: '${state.goal.achievedAmount}ml / ${state.goal.targetAmount}ml',
          trailing: CircularProgressIndicator(
            value: (state.goal.achievedAmount / state.goal.targetAmount).clamp(0.0, 1.0),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00D4FF)),
            backgroundColor: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return _buildSectionCard(
      title: 'Notifications',
      icon: Icons.notifications,
      children: [
        _buildSwitchTile(
          icon: Icons.notifications_active,
          title: 'Enable Notifications',
          subtitle: 'Get reminded to drink water',
          value: _notificationsEnabled,
          onChanged: (value) {
            setState(() => _notificationsEnabled = value);
          },
        ),
        if (_notificationsEnabled) ...[
          _buildSwitchTile(
            icon: Icons.volume_up,
            title: 'Sound',
            subtitle: 'Play sound with notifications',
            value: _soundEnabled,
            onChanged: (value) {
              setState(() => _soundEnabled = value);
            },
          ),
          _buildSwitchTile(
            icon: Icons.vibration,
            title: 'Vibration',
            subtitle: 'Vibrate with notifications',
            value: _vibrationEnabled,
            onChanged: (value) {
              setState(() => _vibrationEnabled = value);
            },
          ),
        ],
      ],
    );
  }

  Widget _buildUnitsSection() {
    return _buildSectionCard(
      title: 'Units & Measurements',
      icon: Icons.straighten,
      children: [
        _buildSettingTile(
          icon: Icons.scale,
          title: 'Measurement Unit',
          subtitle: _selectedUnit,
          trailing: DropdownButton<String>(
            value: _selectedUnit,
            dropdownColor: const Color(0xFF161B22),
            style: const TextStyle(color: Colors.white),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() => _selectedUnit = newValue);
              }
            },
            items: _units.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildReminderSection() {
    return _buildSectionCard(
      title: 'Reminder Settings',
      icon: Icons.schedule,
      children: [
        _buildSettingTile(
          icon: Icons.timer,
          title: 'Reminder Interval',
          subtitle: '$_reminderInterval minutes',
          trailing: DropdownButton<int>(
            value: _reminderInterval,
            dropdownColor: const Color(0xFF161B22),
            style: const TextStyle(color: Colors.white),
            onChanged: (int? newValue) {
              if (newValue != null) {
                setState(() => _reminderInterval = newValue);
              }
            },
            items: _reminderIntervals.map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value min'),
              );
            }).toList(),
          ),
        ),
        _buildSettingTile(
          icon: Icons.wb_sunny,
          title: 'Start Time',
          subtitle: _startTime.format(context),
          trailing: const Icon(Icons.access_time, color: Color(0xFF00D4FF)),
          onTap: () => _selectTime(context, true),
        ),
        _buildSettingTile(
          icon: Icons.nightlight_round,
          title: 'End Time',
          subtitle: _endTime.format(context),
          trailing: const Icon(Icons.access_time, color: Color(0xFF00D4FF)),
          onTap: () => _selectTime(context, false),
        ),
      ],
    );
  }

  Widget _buildDataSection() {
    return _buildSectionCard(
      title: 'Data Management',
      icon: Icons.storage,
      children: [
        _buildSettingTile(
          icon: Icons.history,
          title: 'View History',
          subtitle: 'See your water intake history',
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () {
            // Navigate to history screen
          },
        ),
        _buildSettingTile(
          icon: Icons.file_download,
          title: 'Export Data',
          subtitle: 'Export your data as CSV',
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () => _showExportDialog(),
        ),
        _buildSettingTile(
          icon: Icons.delete_sweep,
          title: 'Clear All Data',
          subtitle: 'Delete all your water tracking data',
          trailing: const Icon(Icons.warning, color: Colors.red),
          onTap: () => _showClearDataDialog(),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return _buildSectionCard(
      title: 'About',
      icon: Icons.info,
      children: [
        _buildSettingTile(
          icon: Icons.app_settings_alt,
          title: 'App Version',
          subtitle: '1.0.0',
        ),
        _buildSettingTile(
          icon: Icons.star,
          title: 'Rate App',
          subtitle: 'Rate us on the App Store',
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () {
            // Open app store rating
          },
        ),
        _buildSettingTile(
          icon: Icons.help,
          title: 'Help & Support',
          subtitle: 'Get help and contact support',
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () {
            // Open help screen
          },
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF00D4FF), size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF00D4FF)),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        subtitle: subtitle != null
            ? Text(
          subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        )
            : null,
        trailing: trailing,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: Colors.transparent,
        hoverColor: Colors.grey[800],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return _buildSettingTile(
      icon: icon,
      title: title,
      subtitle: subtitle,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF00D4FF),
      ),
    );
  }
  void _showGoalBottomSheet(BuildContext context, int currentGoal) {
    final controller = TextEditingController(text: currentGoal.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF161B22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Set Daily Goal',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter goal in ml',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF00D4FF)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickGoalButton('1500ml', 1500, controller),
                  _buildQuickGoalButton('2000ml', 2000, controller),
                  _buildQuickGoalButton('2500ml', 2500, controller),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final newGoal = int.tryParse(controller.text) ?? currentGoal;
                  Navigator.pop(context);

                  await context.read<WaterTrackingCubit>().updateGoal(newGoal);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Goal updated to ${newGoal}ml'),
                        backgroundColor: const Color(0xFF00D4FF),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D4FF),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }


  Widget _buildQuickGoalButton(String text, int value, TextEditingController controller) {
    return ElevatedButton(
      onPressed: () => controller.text = value.toString(),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00D4FF).withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text, style: const TextStyle(color: Color(0xFF00D4FF))),
    );
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _startTime : _endTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00D4FF),
              surface: Color(0xFF161B22),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Export Data',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Export your water intake data as a CSV file?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement export functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data exported successfully'),
                  backgroundColor: Color(0xFF00D4FF),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00D4FF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Export', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF161B22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Clear All Data',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to delete all your water tracking data? This action cannot be undone.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement clear data functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All data cleared'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Clear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}