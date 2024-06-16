import 'package:flutter/material.dart';
import 'package:samplemobileapp/screens/homepage_widgets/assistants_widget.dart';
import 'package:samplemobileapp/screens/homepage_widgets/assistants_widgets_avatar/assitants_avatar.dart';

class AssistantsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Your Assistants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AssistantAvatar(
                  icon: Icons.person_add,
                  name: 'Hire Assistant',
                  onTap: () {
                    // Navigate to hire assistant
                  },
                ),
                AssistantAvatar(
                  imageUrl: 'https://loremflickr.com/100/100?random=1',
                  name: 'Assistant 1',
                  tasksUpdated: 3,
                  taskStatus: 'Active',
                  onTap: () {
                    // Show details for Assistant 1
                    _showDetails(context, 'Assistant 1', 'Active', 'Task 1 details...');
                  },
                ),
                AssistantAvatar(
                  imageUrl: 'https://loremflickr.com/100/100?random=2',
                  name: 'Assistant 2',
                  tasksUpdated: 1,
                  taskStatus: 'Pending',
                  onTap: () {
                    // Show details for Assistant 2
                    _showDetails(context, 'Assistant 2', 'Pending', 'Task 2 details...');
                  },
                ),
                AssistantAvatar(
                  imageUrl: 'https://loremflickr.com/100/100?random=3',
                  name: 'Assistant 3',
                  tasksUpdated: 5,
                  taskStatus: 'Done',
                  onTap: () {
                    // Show details for Assistant 3
                    _showDetails(context, 'Assistant 3', 'Done', 'Task 3 details...');
                  },
                ),
                AssistantAvatar(
                  imageUrl: 'https://loremflickr.com/100/100?random=4',
                  name: 'Assistant 4',
                  tasksUpdated: 0,
                  taskStatus: 'No Task',
                  onTap: () {
                    // Show details for Assistant 4
                    _showDetails(context, 'Assistant 4', 'No Task', 'No tasks assigned.');
                  },
                ),
                AssistantAvatar(
                  imageUrl: 'https://loremflickr.com/100/100?random=5',
                  name: 'Assistant 5',
                  tasksUpdated: 2,
                  taskStatus: 'Updated',
                  onTap: () {
                    // Show details for Assistant 5
                    _showDetails(context, 'Assistant 5', 'Updated', 'Task 5 details...');
                  },
                ),
                // Add more assistants if needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context, String name, String status, String details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Status: $status'),
              SizedBox(height: 10),
              Text('Details: $details'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
