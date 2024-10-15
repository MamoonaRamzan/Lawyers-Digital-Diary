import 'package:flutter/material.dart';

import '../../Model/Shedule.dart';

class SheduleTab extends StatelessWidget {
  final List<Schedule> schedules;

  SheduleTab({required this.schedules});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        return ListTile(
          title: Text(schedule.description,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Color(0xFF4DB6AC) ),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: ${schedule.dateTime}'),
              Text('Location: ${schedule.location}'),
            ],
          ),
          trailing: schedule.reminder
              ? Icon(Icons.notifications_active, color: Colors.red)
              : Icon(Icons.notifications_off, color: Colors.grey),
        );
      },
    );
  }
}


