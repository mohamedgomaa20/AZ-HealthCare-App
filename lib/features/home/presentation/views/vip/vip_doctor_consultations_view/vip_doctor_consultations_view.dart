import 'package:az_health_care/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class VIPDoctorConsultationsView extends StatefulWidget {
  const VIPDoctorConsultationsView({super.key});

  @override
  _VIPDoctorConsultationsViewState createState() =>
      _VIPDoctorConsultationsViewState();
}

class _VIPDoctorConsultationsViewState extends State<VIPDoctorConsultationsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VIP Doctor Consultations'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Available'),
            Tab(text: 'Upcoming'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AvailableDoctorsTab(),
          UpcomingConsultationsTab(),
          ConsultationHistoryTab(),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String status;
  final String date;
  final String? diagnosis;
  final String? prescription;
  final String price;
  final bool isHistory;
  final bool isAvailable;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.status,
    required this.date,
    this.diagnosis,
    this.prescription,
    required this.price,
    this.isHistory = false,
    this.isAvailable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.blueGrayBackground2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      specialty,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
                if (!isAvailable)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          status == 'Completed'
                              ? Colors.green[100]
                              : Colors.red[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color:
                            status == 'Completed' ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(date, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            if (isHistory && diagnosis != null) ...[
              const SizedBox(height: 8),
              Text(
                'Diagnosis: $diagnosis',
                style: const TextStyle(fontSize: 14),
              ),
            ],
            if (isHistory && prescription != null) ...[
              const SizedBox(height: 4),
              Text(
                'Prescription: $prescription',
                style: const TextStyle(fontSize: 14),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                if (isAvailable)
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Book Appointment'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Consult Now'),
                      ),
                    ],
                  )
                else if (isHistory)
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('View Details'),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Download Report'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Reschedule'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Join Call'),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AvailableDoctorsTab extends StatelessWidget {
  const AvailableDoctorsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  SizedBox(width: 8),
                  FilterChip(label: Text('All'), selected: true),
                  SizedBox(width: 8),
                  FilterChip(label: Text('Cardiologist')),
                  SizedBox(width: 8),
                  FilterChip(label: Text('Dermatologist')),
                  SizedBox(width: 8),
                  FilterChip(label: Text('Pediatrician')),
                  SizedBox(width: 8),
                ],
              ),
            ),
          ),
          // Available Doctors List
          const DoctorCard(
            name: 'Dr. Sarah Johnson',
            specialty: 'Cardiologist',
            status: 'Available',
            date: '15 years experience • 4.8 rating',
            price: '\$150.0',
            isAvailable: true,
          ),
          const DoctorCard(
            name: 'Dr. Michael Chen',
            specialty: 'Dermatologist',
            status: 'Available',
            date: '12 years experience • 4.9 rating',
            price: '\$120.0',
            isAvailable: true,
          ),
        ],
      ),
    );
  }
}

class UpcomingConsultationsTab extends StatelessWidget {
  const UpcomingConsultationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          DoctorCard(
            name: 'Dr. Sarah Johnson',
            specialty: 'Cardiologist',
            status: 'Upcoming',
            date: '2024-01-20 at 10:00 AM • Video Call',
            price: '\$150.0',
          ),
          DoctorCard(
            name: 'Dr. Michael Chen',
            specialty: 'Dermatologist',
            status: 'Upcoming',
            date: '2024-01-22 at 2:30 PM • Phone Call',
            price: '\$120.0',
          ),
          DoctorCard(
            name: 'Dr. Emily Rodriguez',
            specialty: 'Pediatrician',
            status: 'Upcoming',
            date: '2024-01-25 at 11:00 AM • Video Call',
            price: '\$100.0',
          ),
        ],
      ),
    );
  }
}

class ConsultationHistoryTab extends StatelessWidget {
  const ConsultationHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          DoctorCard(
            name: 'Dr. David Wilson',
            specialty: 'Neurologist',
            status: 'Completed',
            date: '2024-01-15',
            diagnosis: 'Migraine headaches',
            prescription: 'Prescribed pain medication',
            price: '\$200.0',
            isHistory: true,
          ),
          DoctorCard(
            name: 'Dr. Lisa Thompson',
            specialty: 'Psychiatrist',
            status: 'Completed',
            date: '2024-01-10',
            diagnosis: 'Anxiety disorder',
            prescription: 'Therapy sessions recommended',
            price: '\$180.0',
            isHistory: true,
          ),
          DoctorCard(
            name: 'Dr. Robert Kim',
            specialty: 'Orthopedic Surgeon',
            status: 'Cancelled',
            date: '2024-01-05',
            price: '\$250.0',
            isHistory: true,
          ),
        ],
      ),
    );
  }
}

class FilterChip extends StatelessWidget {
  final Widget label;
  final bool selected;

  const FilterChip({super.key, required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: selected ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: selected ? Colors.blue : Colors.grey),
      ),
      child: Center(
        child: DefaultTextStyle(
          style: TextStyle(color: selected ? Colors.white : Colors.black),
          child: label,
        ),
      ),
    );
  }
}
