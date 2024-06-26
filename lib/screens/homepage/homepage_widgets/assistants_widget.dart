import 'package:flutter/material.dart';

import '../../../utils/colors/colors.dart';


class AssistantsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Your Assistants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkTheme ? AppColors.darkText : AppColors.lightText),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AssistantAvatar(
                  icon: Icons.person_add,
                  name: 'Hire Assistant',
                  darkTheme: darkTheme,
                  onTap: () {
                    // Navigate to hire assistant
                  },
                ),
                AssistantAvatar(
                  imageUrl: 'https://loremflickr.com/100/100?random=1',
                  name: 'Assistant 1',
                  tasksUpdated: 3,
                  taskStatus: 'Active',
                  darkTheme: darkTheme,
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
                  darkTheme: darkTheme,
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
                  darkTheme: darkTheme,
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
                  darkTheme: darkTheme,
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
                  darkTheme: darkTheme,
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

class AssistantAvatar extends StatelessWidget {
  final String? imageUrl;
  final IconData? icon;
  final String name;
  final VoidCallback onTap;
  final int? tasksUpdated;
  final String? taskStatus;
  final bool darkTheme;

  AssistantAvatar({
    this.imageUrl,
    this.icon,
    required this.name,
    required this.onTap,
    this.tasksUpdated,
    this.taskStatus,
    required this.darkTheme,
  });

  LinearGradient _getGradient() {
    switch (taskStatus) {
      case 'Pending':
        return LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Active':
        return LinearGradient(
          colors: [Colors.deepOrange, Colors.orange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Done':
        return LinearGradient(
          colors: [Colors.purple, Colors.deepPurpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'No Task':
        return LinearGradient(
          colors: [Colors.blueGrey, Colors.grey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 'Updated':
        return LinearGradient(
          colors: [Colors.yellow, Colors.amber],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return LinearGradient(
          colors: [Colors.grey, Colors.black54],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _getGradient(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2), // Space between the border and the avatar
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 26,
                        backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
                        child: icon != null ? Icon(icon, size: 30, color: Colors.grey) : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(name, style: TextStyle(fontSize: 14, color: darkTheme ? AppColors.darkText : AppColors.lightText)),
              ],
            ),
            if (tasksUpdated != null)
              Positioned(
                top: 5,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$tasksUpdated',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            if (taskStatus != null)
              Positioned(
                top: 0,
                left: -5, // Adjusted position to left outside the container
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    gradient: _getGradient(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    taskStatus!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right, // Ensure text alignment to the right
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
