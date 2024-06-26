import 'package:flutter/material.dart';

class ServiceHighlights extends StatelessWidget {
  final List<String> services = [
    'Advanced Matching Algorithm',
    'Integrated Communication Tools',
    'Time Tracking and Reporting',
    'Secure Payment Gateway',
    'Customizable Service Packages',
    'Client and VA Rating System',
    'Document and File Sharing',
    'Priority Task Handling',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Service Highlights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...services.map((service) => ServiceTile(service: service)).toList(),
        ],
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String service;

  ServiceTile({required this.service});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(service, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
