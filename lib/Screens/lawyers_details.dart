import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/Model/Profile.dart';
import '../Model/Lawyer.dart';
import 'Widgets/CasesTab.dart';
import 'Widgets/Client Tab.dart';
import 'Widgets/ProfileTab.dart';
import 'Widgets/SheduleTab.dart';

class LawyerDetail extends StatelessWidget {
  final Lawyer lawyer;

  LawyerDetail({required this.lawyer});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Four tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(lawyer.profile.name),
          bottom: TabBar(
            indicatorColor: Color(0xFF4DB6AC),
            labelColor: Color(0xFF4DB6AC),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
              return Color(0xFF4DB6AC).withOpacity(0.2); // Splash color when pressed
              }
              return Color(0xFF4DB6AC).withOpacity(0.2); // Default splash color
              }),
            tabs: [
              Tab(text: 'Profile'),
              Tab(text: 'Clients'),
              Tab(text: 'Cases'),
              Tab(text: 'Schedule'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProfileTab(profile: lawyer.profile), // First tab - Profile
            ClientsPage(clients: lawyer.clients),             // Second tab - Clients
            CasesTab(Cases: lawyer.cases),                // Third tab - Cases
            SheduleTab(schedules: lawyer.schedule)               // Fourth tab - Schedule
          ],
        ),
      ),
    );
  }
}

