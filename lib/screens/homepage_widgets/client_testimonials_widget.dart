import 'package:flutter/material.dart';

class ClientTestimonials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Client Testimonials', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          TestimonialTile(
            clientName: 'Alice Johnson',
            feedback: 'Excellent service! My virtual assistant has been a game changer for my business.',
          ),
          TestimonialTile(
            clientName: 'Michael Lee',
            feedback: 'Highly professional and efficient. Highly recommend!',
          ),
          // Add more testimonials here
        ],
      ),
    );
  }
}

class TestimonialTile extends StatelessWidget {
  final String clientName;
  final String feedback;

  TestimonialTile({required this.clientName, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(clientName, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(feedback),
    );
  }
}
