import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayDetailPage extends StatelessWidget {
  final DateTime date;
  final List<String> tasks;

  const DayDetailPage({Key? key, required this.date, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('MMMM d, yyyy').format(date)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tasks for ${DateFormat('MMMM d, yyyy').format(date)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(_getIconForTask(tasks[index])),
                    title: Text(tasks[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForTask(String task) {
    switch (task) {
      case 'General Virtual Assistant':
        return Icons.person;
      case 'Social Media Management':
        return Icons.social_distance;
      case 'Computer Technical VA':
        return Icons.computer;
      case 'Graphical Creation VA':
        return Icons.design_services;
      case 'Administrative VA':
        return Icons.admin_panel_settings;
      case 'Marketing VA':
        return Icons.mark_email_read;
      default:
        return Icons.task;
    }
  }
}
