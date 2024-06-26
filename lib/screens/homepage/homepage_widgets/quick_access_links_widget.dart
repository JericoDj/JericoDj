import 'package:flutter/material.dart';

class QuickAccessLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate to task creation page
            },
            child: Text('Create a New Task'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to support/contact page
            },
            child: Text('Contact Support'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to reports/analytics page
            },
            child: Text('View Reports'),
          ),
        ],
      ),
    );
  }
}
