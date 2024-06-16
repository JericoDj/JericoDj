import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text(
            'Welcome to Your Virtual Assistant Dashboard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Manage your tasks efficiently with our professional virtual assistants.',
            style: TextStyle(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
