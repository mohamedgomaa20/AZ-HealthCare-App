import 'package:flutter/material.dart';
import '../data/database/database_helper.dart';
import '../data/models/step_data.dart';
import '../data/models/running_session.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/running_session_card.dart';
import '../widgets/step_card_history_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<StepData> _stepHistory = [];
  List<RunningSession> _runningHistory = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadHistory();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    setState(() => _isLoading = true);

    try {
      final stepData = await DatabaseHelper.getLastSevenDays();
      final runningData = await DatabaseHelper.getRunningHistory();

      setState(() {
        _stepHistory = stepData;
        _runningHistory = runningData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading history: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF6366F1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.directions_walk), text: 'Daily Steps'),
            Tab(icon: Icon(Icons.directions_run), text: 'Running Sessions'),
          ],
        ),
      ),
      body:
          _isLoading
              ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                ),
              )
              : TabBarView(
                controller: _tabController,
                children: [_buildStepHistoryTab(), _buildRunningHistoryTab()],
              ),
    );
  }

  Widget _buildStepHistoryTab() {
    if (_stepHistory.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.directions_walk,
        title: 'No Step Data Yet',
        subtitle: 'Start walking to see your daily progress here!',
      );
    }

    return RefreshIndicator(
      onRefresh: _loadHistory,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _stepHistory.length,
        itemBuilder: (context, index) {
          final stepData = _stepHistory[index];
          return StepCardWidget(stepData: stepData);
        },
      ),
    );
  }

  Widget _buildRunningHistoryTab() {
    if (_runningHistory.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.directions_run,
        title: 'No Running Sessions Yet',
        subtitle: 'Start your first running session to track your progress!',
      );
    }

    return RefreshIndicator(
      onRefresh: _loadHistory,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _runningHistory.length,
        itemBuilder: (context, index) {
          final session = _runningHistory[index];
          return RunningSessionCard(session: session);
        },
      ),
    );
  }
}
