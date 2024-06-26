import 'package:flutter/material.dart';

class RecentActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ActivityTile(
            title: 'Task: Design Logo',
            description: 'Completed by VA - Jane Smith',
            time: '2 hours ago',
          ),
          ActivityTile(
            title: 'Task: Data Entry',
            description: 'In progress by VA - John Brown',
            time: '5 hours ago',
          ),
          // Add more activities here
        ],
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final String title;
  final String description;
  final String time;

  ActivityTile({required this.title, required this.description, required this.time});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      trailing: Text(time),
    );
  }
}
