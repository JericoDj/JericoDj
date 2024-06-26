import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors/colors.dart';
import '../messages_page/messages_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Assistant App',style: TextStyle(color: AppColors.darkText),),
        backgroundColor: darkTheme ? AppColors.darkBackground: AppColors.darkBackground,
        actions: [
          IconButton(
            icon: const Icon(Icons.message,color: AppColors.darkText,),
            onPressed: () {
              Get.to(() => const MessagesPage());
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          AssistantsSection(darkTheme: darkTheme),
          WelcomeSection(darkTheme: darkTheme),
          VANichesSection(darkTheme: darkTheme),
          RecentActivities(darkTheme: darkTheme),
          PerformanceMetrics(darkTheme: darkTheme),
          ServiceHighlights(darkTheme: darkTheme),
          ClientTestimonials(darkTheme: darkTheme),
          QuickAccessLinks(darkTheme: darkTheme),
        ],
      ),
    );
  }
}

class AssistantsSection extends StatelessWidget {
  final bool darkTheme;

  AssistantsSection({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Your Assistants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkTheme ? AppColors.darkText : AppColors.lightText),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AssistantAvatar(
                  imageUrl: 'https://loremflickr.com/100/100?random=1',
                  name: 'Assistant 1',
                  tasksUpdated: 3,
                  taskStatus: 'Active',
                  darkTheme: darkTheme,
                  onTap: () {
                    // Navigate to Assistant 1 details or tasks
                  },
                ),
                AssistantAvatar(
                  imageUrl: 'https://loremflickr.com/100/100?random=2',
                  name: 'Assistant 2',
                  tasksUpdated: 1,
                  taskStatus: 'Pending',
                  darkTheme: darkTheme,
                  onTap: () {
                    // Navigate to Assistant 2 details or tasks
                  },
                ),
                AssistantAvatar(
                  imageUrl: 'https://loremflickr.com/100/100?random=3',
                  name: 'Assistant 3',
                  tasksUpdated: 5,
                  taskStatus: 'Done',
                  darkTheme: darkTheme,
                  onTap: () {
                    // Navigate to Assistant 3 details or tasks
                  },
                ),
                AssistantAvatar(
                  imageUrl: 'https://loremflickr.com/100/100?random=4',
                  name: 'Assistant 4',
                  tasksUpdated: 0,
                  taskStatus: 'No Task',
                  darkTheme: darkTheme,
                  onTap: () {
                    // Navigate to Assistant 4 details or tasks
                  },
                ),
                AssistantAvatar(
                  imageUrl: 'https://loremflickr.com/100/100?random=5',
                  name: 'Assistant 5',
                  tasksUpdated: 2,
                  taskStatus: 'Updated',
                  darkTheme: darkTheme,
                  onTap: () {
                    // Navigate to Assistant 5 details or tasks
                  },
                ),
                AssistantAvatar(
                  icon: Icons.person_add,
                  name: 'Hire Assistant',
                  darkTheme: darkTheme,
                  onTap: () {
                    // Navigate to hire assistant
                  },
                ),
                // Add more assistants if needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AssistantAvatar extends StatelessWidget {
  final String? imageUrl;
  final IconData? icon;
  final String name;
  final VoidCallback onTap;
  final int? tasksUpdated;
  final String? taskStatus;
  final bool darkTheme;

  AssistantAvatar({
    this.imageUrl,
    this.icon,
    required this.name,
    required this.onTap,
    this.tasksUpdated,
    this.taskStatus,
    required this.darkTheme,
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
        margin: const EdgeInsets.symmetric(horizontal: 10),
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
                const SizedBox(height: 5),
                Text(name, style: TextStyle(fontSize: 14, color: darkTheme ? AppColors.darkText : AppColors.lightText)),
              ],
            ),
            if (tasksUpdated != null)
              Positioned(
                top: 5,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$tasksUpdated',
                    style: const TextStyle(
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
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    gradient: _getGradient(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    taskStatus!,
                    style: const TextStyle(
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

class VANichesSection extends StatelessWidget {
  final bool darkTheme;
  final List<String> vaNiches = [
    'General Virtual Assistant',
    'Social Media Management',
    'Computer Technical VA',
    'Graphical Creation VA',
    'Administrative VA',
    'Marketing VA',
  ];

  VANichesSection({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('VA Niches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkTheme ? AppColors.darkText : AppColors.lightText)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: vaNiches.map((niche) => VAContainer(niche: niche, darkTheme: darkTheme)).toList(),
          ),
        ],
      ),
    );
  }
}

class VAContainer extends StatelessWidget {
  final String niche;
  final bool darkTheme;

  const VAContainer({required this.niche, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 2,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            darkTheme ? AppColors.primary.withOpacity(0.8) : AppColors.paletteGreen3,
            darkTheme ? AppColors.darkBackground.withOpacity(0.8) : AppColors.paletteCyan3,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        niche,
        style: const TextStyle(fontSize: 16, color: AppColors.darkText, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class WelcomeSection extends StatelessWidget {
  final bool darkTheme;

  const WelcomeSection({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            darkTheme ? AppColors.primary.withOpacity(0.8) : AppColors.paletteGreen2,
            darkTheme ? AppColors.darkBackground.withOpacity(0.8) : AppColors.paletteCyan2 ,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Column(
        children: const [
          Text(
            'Welcome to Your Virtual Assistant Dashboard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.darkText),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Manage your tasks efficiently with our professional virtual assistants.',
            style: TextStyle(fontSize: 16, color: AppColors.darkText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class RecentActivities extends StatelessWidget {
  final bool darkTheme;

  const RecentActivities({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkTheme ? AppColors.darkText : AppColors.lightText)),
          const SizedBox(height: 10),
          const ActivityTile(
            title: 'Task: Design Logo',
            description: 'Completed by VA - Jane Smith',
            time: '2 hours ago',
          ),
          const ActivityTile(
            title: 'Task: Data Entry',
            description: 'In progress by VA - John Brown',
            time: '5 hours ago',
          ),
          // Add more activities here
        ],
      ),
    );
  }
}

class ActivityTile extends StatelessWidget {
  final String title;
  final String description;
  final String time;

  const ActivityTile({
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      trailing: Text(time),
    );
  }
}

class PerformanceMetrics extends StatelessWidget {
  final bool darkTheme;

  const PerformanceMetrics({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Performance Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkTheme ? AppColors.darkText : AppColors.lightText)),
          const SizedBox(height: 10),
          const MetricTile(
            metric: 'Tasks Completed',
            value: '120',
          ),
          const MetricTile(
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

  const MetricTile({
    required this.metric,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(metric, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class ServiceHighlights extends StatelessWidget {
  final bool darkTheme;
  final List<String> services = const [
    'Advanced Matching Algorithm',
    'Integrated Communication Tools',
    'Time Tracking and Reporting',
    'Secure Payment Gateway',
    'Customizable Service Packages',
    'Client and VA Rating System',
    'Document and File Sharing',
    'Priority Task Handling',
  ];

  ServiceHighlights({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Service Highlights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkTheme ? AppColors.darkText : AppColors.lightText)),
          const SizedBox(height: 10),
          ...services.map((service) => ServiceTile(service: service, darkTheme: darkTheme)).toList(),
        ],
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String service;
  final bool darkTheme;

  const ServiceTile({
    required this.service,
    required this.darkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(service, style: TextStyle(fontWeight: FontWeight.bold, color: darkTheme ? AppColors.darkText : AppColors.lightText)),
    );
  }
}

class ClientTestimonials extends StatelessWidget {
  final bool darkTheme;

  const ClientTestimonials({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Client Testimonials', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkTheme ? AppColors.darkText : AppColors.lightText)),
          const SizedBox(height: 10),
          const TestimonialTile(
            clientName: 'Alice Johnson',
            feedback: 'Excellent service! My virtual assistant has been a game changer for my business.',
          ),
          const TestimonialTile(
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

  const TestimonialTile({
    required this.clientName,
    required this.feedback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(clientName, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(feedback),
    );
  }
}

class QuickAccessLinks extends StatelessWidget {
  final bool darkTheme;

  const QuickAccessLinks({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate to task creation page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: darkTheme ? AppColors.buttonGradientStart : AppColors.buttonGradientEnd,
            ),
            child: const Text('Create a New Task'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to support/contact page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: darkTheme ? AppColors.buttonGradientStart : AppColors.buttonGradientEnd,
            ),
            child: const Text('Contact Support'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to reports/analytics page
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: darkTheme ? AppColors.buttonGradientStart : AppColors.buttonGradientEnd,
            ),
            child: const Text('View Reports'),
          ),
        ],
      ),
    );
  }
}
