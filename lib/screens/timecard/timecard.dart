import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

void main() {
  runApp(TimeInTimeOutApp());
}

class TimeInTimeOutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time In/Out App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimeCardHome(),
    );
  }
}

class TimeCardHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Card Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TimeCardScreen()),
            );
          },
          child: Text('View Time Card'),
        ),
      ),
    );
  }
}

class TimeCardScreen extends StatefulWidget {
  @override
  _TimeCardScreenState createState() => _TimeCardScreenState();
}

class _TimeCardScreenState extends State<TimeCardScreen> {
  List<TimeEntry> timeEntries = List.generate(31, (index) => TimeEntry(day: index + 1));
  String employeeName = "John Doe"; // Replace with dynamic employee name if needed
  String month = DateFormat('MMMM').format(DateTime.now());
  String correctPin = "000000"; // Default PIN, to be replaced with a secure method in the future

  int getCurrentDay() {
    return DateTime.now().day;
  }

  Future<void> _showPinDialog(Function onCorrectPin) async {
    String enteredPin = "";
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter PIN'),
          content: Pinput(
            length: 6,
            onChanged: (value) {
              enteredPin = value;
            },
            onCompleted: (value) {
              if (value == correctPin) {
                Navigator.of(context).pop();
                onCorrectPin();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Incorrect PIN, try again.')),
                );
              }
            },
            defaultPinTheme: PinTheme(
              width: 40,
              height: 55,
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (enteredPin == correctPin) {
                  Navigator.of(context).pop();
                  onCorrectPin();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Incorrect PIN, try again.')),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _timeIn() {
    _showPinDialog(() {
      int today = getCurrentDay();
      setState(() {
        timeEntries[today - 1].timeIn = DateTime.now();
      });
    });
  }

  void _timeOut() {
    _showPinDialog(() {
      int today = getCurrentDay();
      setState(() {
        timeEntries[today - 1].timeOut = DateTime.now();
      });
    });
  }

  String _formatDate(DateTime? date) {
    return date != null ? DateFormat('HH:mm:ss').format(date) : '';
  }

  String _computeTotalHours(DateTime? timeIn, DateTime? timeOut) {
    if (timeIn != null && timeOut != null) {
      final duration = timeOut.difference(timeIn);
      return duration.inHours.toString().padLeft(2, '0') +
          ':' +
          (duration.inMinutes % 60).toString().padLeft(2, '0');
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Time Card'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Employee: $employeeName', style: TextStyle(fontSize: 18)),
                Text('Month: $month', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Time In')),
                    DataColumn(label: Text('Time Out')),
                    DataColumn(label: Text('Total Hours')),
                  ],
                  rows: timeEntries.map((entry) {
                    return DataRow(
                      cells: [
                        DataCell(Text(entry.day.toString())),
                        DataCell(Text(_formatDate(entry.timeIn))),
                        DataCell(Text(_formatDate(entry.timeOut))),
                        DataCell(Text(_computeTotalHours(entry.timeIn, entry.timeOut))),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _timeIn,
                  child: Text('Time In'),
                ),
                ElevatedButton(
                  onPressed: _timeOut,
                  child: Text('Time Out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimeEntry {
  final int day;
  DateTime? timeIn;
  DateTime? timeOut;

  TimeEntry({required this.day, this.timeIn, this.timeOut});
}
