import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../messages_page/messages_page.dart';


class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Get.to(MessagesPage());
            },
          ),
        ],
      ),
      body: ReportsOverview(),
    );
  }
}

class ReportsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Tasks Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: TasksChart(),
        ),
        const SizedBox(height: 20),
        Text('Performance Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: PerformanceChart(),
        ),
      ],
    );
  }
}

class TasksChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(value: 40, color: Colors.blue, title: 'Completed'),
          PieChartSectionData(value: 20, color: Colors.orange, title: 'Pending'),
          PieChartSectionData(value: 10, color: Colors.green, title: 'In Progress'),
          PieChartSectionData(value: 5, color: Colors.red, title: 'Overdue'),
        ],
      ),
    );
  }
}

class PerformanceChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [BarChartRodData(toY: 50, color: Colors.blue)],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [BarChartRodData(toY: 100, color: Colors.blue)],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [BarChartRodData(toY: 150, color: Colors.blue)],
            showingTooltipIndicators: [0],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [BarChartRodData(toY: 200, color: Colors.blue)],
            showingTooltipIndicators: [0],
          ),
        ],
      ),
    );
  }
}
