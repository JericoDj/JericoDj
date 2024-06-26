import 'package:flutter/material.dart';

class AssistantAvatar extends StatelessWidget {
  final String? imageUrl;
  final IconData? icon;
  final String name;
  final VoidCallback onTap;
  final int? tasksUpdated;
  final String? taskStatus;

  AssistantAvatar({
    this.imageUrl,
    this.icon,
    required this.name,
    required this.onTap,
    this.tasksUpdated,
    this.taskStatus,
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
        margin: EdgeInsets.symmetric(horizontal: 10),
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
                SizedBox(height: 5),
                Text(name, style: TextStyle(fontSize: 14)),
              ],
            ),
            if (tasksUpdated != null)
              Positioned(
                top: 5,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$tasksUpdated',
                    style: TextStyle(
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
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    gradient: _getGradient(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    taskStatus!,
                    style: TextStyle(
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
