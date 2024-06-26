import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: MessagesOverview(),
    );
  }
}

class MessagesOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        MessageTile(
          vaName: 'VA 1',
          message: 'I have completed the task.',
          time: '2 hours ago',
        ),
        MessageTile(
          vaName: 'VA 2',
          message: 'I need more details about the task.',
          time: '5 hours ago',
        ),
        // Add more MessageTiles here
      ],
    );
  }
}

class MessageTile extends StatelessWidget {
  final String vaName;
  final String message;
  final String time;

  MessageTile({
    required this.vaName,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(vaName),
        subtitle: Text(message),
        trailing: Text(time),
      ),
    );
  }
}
