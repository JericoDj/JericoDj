import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:async';

class ViewExcelPage extends StatefulWidget {
  @override
  _ViewExcelPageState createState() => _ViewExcelPageState();
}

class _ViewExcelPageState extends State<ViewExcelPage> {
  List<List<String>>? excelData;

  @override
  void initState() {
    super.initState();
    _loadExcelFromAssets();
  }

  Future<void> _loadExcelFromAssets() async {
    // Load the file from the assets folder
    ByteData data = await rootBundle.load('assets/schedule/VA_Schedule_Simplified_Breakdown.xlsx');
    var bytes = data.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);

    List<List<String>> tempData = [];

    for (var table in excel.tables.keys) {
      var sheet = excel.tables[table];
      if (sheet != null) {
        for (var row in sheet.rows) {
          List<String> rowData = row.map((cell) => cell?.value.toString() ?? '').toList();
          tempData.add(rowData);
        }
      }
    }

    setState(() {
      excelData = tempData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VA Schedule Breakdown'),
      ),
      body: Column(
        children: [
          Expanded(
            child: excelData != null
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: excelData!.isNotEmpty
                      ? excelData!.first
                      .map((header) => DataColumn(label: Text(header)))
                      .toList()
                      : [],
                  rows: excelData!.skip(1).map((row) {
                    // Ensure that each row has the same number of cells as the headers
                    while (row.length < excelData!.first.length) {
                      row.add(''); // Fill with empty strings if the row is short
                    }
                    return DataRow(
                      cells: row.map((cell) {
                        return DataCell(Text(cell));
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            )
                : Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
