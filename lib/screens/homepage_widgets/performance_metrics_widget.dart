import 'package:flutter/material.dart';

class PerformanceMetrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Performance Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          MetricTile(
            metric: 'Tasks Completed',
            value: '120',
          ),
          MetricTile(
            metric: 'Hours Logged',
            value: '250',
          ),
          // Add more metrics here
        ],
      ),
    );
  }
}

class MetricTile extends StatelessWidget {
  final String metric;
  final String value;

  MetricTile({required this.metric, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(metric, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
