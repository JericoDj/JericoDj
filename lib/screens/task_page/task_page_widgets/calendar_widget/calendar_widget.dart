import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../day_detail_page.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late PageController _pageController;
  late DateTime _startDate;
  late int _currentPage;

  // Static data for the number of assistants assigned tasks each day
  final Map<DateTime, Map<String, dynamic>> _tasksPerDay = {
    DateTime(2024, 7, 1): {'tasks': ['General Virtual Assistant'], 'count': 2},
    DateTime(2024, 7, 2): {
      'tasks': ['Social Media Management', 'Computer Technical VA'],
      'count': 3
    },
    DateTime(2024, 7, 3): {
      'tasks': ['Graphical Creation VA', 'Administrative VA', 'Marketing VA'],
      'count': 6
    },
    DateTime(2024, 7, 4): {
      'tasks': [
        'General Virtual Assistant',
        'Social Media Management',
        'Computer Technical VA',
        'Graphical Creation VA'
      ],
      'count': 7
    },
    DateTime(2024, 7, 5): {'tasks': ['General Virtual Assistant'], 'count': 3},
    DateTime(2024, 7, 6): {
      'tasks': ['Social Media Management', 'Computer Technical VA'],
      'count': 5
    },
    DateTime(2024, 7, 7): {
      'tasks': ['Graphical Creation VA', 'Administrative VA', 'Marketing VA'],
      'count': 6
    },
    DateTime(2024, 7, 8): {
      'tasks': [
        'General Virtual Assistant',
        'Social Media Management',
        'Computer Technical VA',
        'Graphical Creation VA'
      ],
      'count': 7
    },
    DateTime(2024, 7, 9): {'tasks': ['General Virtual Assistant'], 'count': 4},
    DateTime(2024, 7, 10): {
      'tasks': ['Social Media Management', 'Computer Technical VA'],
      'count': 5
    },
  };

  final Map<String, IconData> _nicheIcons = {
    'General Virtual Assistant': Icons.person,
    'Social Media Management': Icons.social_distance,
    'Computer Technical VA': Icons.computer,
    'Graphical Creation VA': Icons.design_services,
    'Administrative VA': Icons.admin_panel_settings,
    'Marketing VA': Icons.mark_email_read,
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1000, viewportFraction: 0.2);
    _startDate = DateTime.now();
    _currentPage = 1000;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToToday() {
    setState(() {
      _currentPage = 1000;
      _pageController.jumpToPage(_currentPage);
    });
  }

  void _scrollDays(int days) {
    setState(() {
      _currentPage += days;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  String _getMonthName(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  DateTime _getDateWithoutTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  void _onDateTap(DateTime date) {
    List<String> tasks =
        _tasksPerDay[_getDateWithoutTime(date)]?['tasks'] ?? [];
    Get.to(() => DayDetailPage(date: date, tasks: tasks));
  }

  void _onMonthTap(DateTime date) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tasks for ${_getMonthName(date)}'),
        content: MonthDetailView(date: date, tasksPerDay: _tasksPerDay),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentMonth = _startDate.add(Duration(days: _currentPage - 1000));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => _scrollDays(-30), // Scroll back by 1 month
              ),
              GestureDetector(
                onTap: () => _onMonthTap(currentMonth),
                child: Text(
                  _getMonthName(currentMonth),
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => _scrollDays(30), // Scroll forward by 1 month
              ),
            ],
          ),
        ),
        SizedBox(
          height: 150, // Adjusted height to ensure visibility
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              DateTime date = _startDate.add(Duration(days: index - 1000));
              List<String> niches =
                  _tasksPerDay[_getDateWithoutTime(date)]?['tasks'] ?? [];
              print(
                  'Date: ${DateFormat('yyyy-MM-dd').format(date)}, Niches: ${niches.join(', ')}');
            },
            itemBuilder: (context, index) {
              DateTime date = _startDate.add(Duration(days: index - 1000));
              return GestureDetector(
                onTap: () => _onDateTap(date),
                child: Column(
                  children: [
                    Text(
                      DateFormat('EEE').format(date),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('d').format(date),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: _buildDayContainer(date)),
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _scrollDays(-5),
              child: Text('Previous 5 Days'),
            ),
            ElevatedButton(
              onPressed: _goToToday,
              child: Text('Today'),
            ),
            ElevatedButton(
              onPressed: () => _scrollDays(5),
              child: Text('Next 5 Days'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDayContainer(DateTime date) {
    List<String> niches =
    _tasksPerDay[_getDateWithoutTime(date)]?[
    'tasks'] ?? [];
    int assistantCount = _tasksPerDay[_getDateWithoutTime(date)]?['count'] ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.transparent, // Transparent background
        border: Border.all(color: Colors.blue, width: 2.0), // Blue border
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildAssistantIcons(assistantCount),
          ),
          if (niches.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildNicheIcons(niches),
              ),
            ),
          if (assistantCount > 0)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                assistantCount == 0 ? 'Task' : '',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (assistantCount == 0)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'No Task',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildNicheIcons(List<String> niches) {
    List<Widget> icons = [];
    for (int i = 0; i < niches.length && i < 3; i++) {
      icons.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: CircleAvatar(
          radius: 6, // Adjusted size for better fit
          backgroundColor: _getColorForTask(i),
          child: Icon(
            _nicheIcons[niches[i]],
            size: 10.0,
            color: Colors.white,
          ),
        ),
      ));
    }
    if (niches.length > 3) {
      icons.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: CircleAvatar(
          radius: 6, // Adjusted size for better fit
          backgroundColor: Colors.white,
          child: Text(
            '+',
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
    }
    return icons;
  }

  List<Widget> _buildAssistantIcons(int count) {
    List<Widget> icons = [];
    for (int i = 0; i < count && i < 3; i++) {
      icons.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: CircleAvatar(
          radius: 4, // Adjusted size for better fit
          backgroundColor: Colors.blue,
        ),
      ));
    }
    if (count > 3) {
      icons.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: CircleAvatar(
          radius: 4, // Adjusted size for better fit
          backgroundColor: Colors.white,
          child: Text(
            '+',
            style: TextStyle(
              color: Colors.black,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
    }
    return icons;
  }

  Color _getColorForTask(int index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      default:
        return Colors.blue;
    }
  }
}

class MonthDetailView extends StatefulWidget {
  final DateTime date;
  final Map<DateTime, Map<String, dynamic>> tasksPerDay;

  const MonthDetailView(
      {Key? key, required this.date, required this.tasksPerDay})
      : super(key: key);

  @override
  _MonthDetailViewState createState() => _MonthDetailViewState();
}

class _MonthDetailViewState extends State<MonthDetailView> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.date;
    _logTasksForMonth();
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  void _logTasksForMonth() {
    int daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    print('Month: ${DateFormat('MMMM yyyy').format(_currentMonth)}');
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime day = DateTime(_currentMonth.year, _currentMonth.month, i);
      int taskCount = widget.tasksPerDay[day]?['count'] ?? 0;
      print(
          'Date: ${DateFormat('yyyy-MM-dd').format(day)}, Task Count: $taskCount');
    }
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

    return Container(
      width: double.maxFinite,
      height: 600, // Increased height for better fit
      child: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _previousMonth,
                ),
                Text(
                  DateFormat('MMMM yyyy').format(_currentMonth),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: _nextMonth,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisExtent: 100, // Adjusted for better spacing
                childAspectRatio: 1.0,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              itemCount: daysInMonth,
              itemBuilder: (context, index) {
                DateTime day = DateTime(
                    _currentMonth.year, _currentMonth.month, index + 1);
                int taskCount = widget.tasksPerDay[day]?['count'] ?? 0;
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => DayDetailPage(
                        date: day,
                        tasks: widget.tasksPerDay[day]?['tasks'] ?? []));
                  },
                  child: Column(
                    children: [
                      Text(
                        (index + 1).toString(),
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent, // Transparent background
                            border:
                            Border.all(color: Colors.blue, width: 1.0), // Blue border
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 16, // Adjusted radius for better fit
                                backgroundColor:
                                taskCount > 0 ? Colors.blue : Colors.grey,
                                child: Text(
                                  taskCount > 0 ? taskCount.toString() : 'No',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                // Added padding for spacing
                                child: Text(
                                  taskCount >= 2 ? 'Tasks' : 'Task',
                                  style: TextStyle(
                                    fontSize: 12, // Adjusted font size for better fit
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
