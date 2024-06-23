import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samplemobileapp/screens/messages_page.dart';
import 'package:samplemobileapp/screens/profile_widgets/addresses_widget.dart';
import 'package:samplemobileapp/screens/profile_widgets/other_page_widget.dart';
import 'package:samplemobileapp/screens/profile_widgets/payment_methods_widget.dart';
import 'package:samplemobileapp/screens/profile_widgets/support_widget.dart';

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
              Get.to(() => const MessagesPage());
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
          onTap: () {
            // Navigate to profile settings page if needed
          },
        ),
        const SizedBox(height: 20),
        ProfileSection(
          title: 'Addresses',
          icon: Icons.location_on,
          onTap: () {
            Get.to(() => AddressesPage());
          },
        ),
        ProfileSection(
          title: 'Payment Methods',
          icon: Icons.credit_card,
          onTap: () {
            Get.to(() => PaymentMethodsPage());
          },
        ),
        ProfileSection(
          title: ' Contact Support',
          icon: Icons.help,
          onTap: () {
            Get.to(() => SupportPage());
          },
        ),
        ProfileSection(
          title: 'Other Settings',
          icon: Icons.settings,
          onTap: () {
            Get.to(() => OtherSettingsPage());
          },
        ),
        const SizedBox(height: 20),
        ListTile(
          leading: Icon(Icons.logout, color: Colors.red),
          title: Text('Logout', style: TextStyle(color: Colors.red)),
          onTap: () {
            // Implement logout functionality
          },
        ),
      ],
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ProfileSection({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
