import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samplemobileapp/screens/messages_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Get.to(MessagesPage());
            },
          ),
        ],
      ),
      body: ProfileOverview(),
    );
  }
}

class ProfileOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(20),
          leading: CircleAvatar(
            backgroundImage: NetworkImage('https://loremflickr.com/100/100?random=4'),
            radius: 30,
          ),
          title: Text('John Doe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          subtitle: Text('Premium Plan Member'),
          trailing: Icon(Icons.settings),
        ),
        // Add more profile details here
      ],
    );
  }
}
