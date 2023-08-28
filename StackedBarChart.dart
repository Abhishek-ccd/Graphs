// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewCustomWidget extends StatefulWidget {
  const NewCustomWidget({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _NewCustomWidgetState createState() => _NewCustomWidgetState();
}

class _NewCustomWidgetState extends State<NewCustomWidget> {
  List<SalesData> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://demo3389010.mockable.io/data/'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final dataList = List<Map<String, dynamic>>.from(jsonData);

      setState(() {
        _data = dataList
            .map((data) => SalesData(
                data['year'], data['sales1'], data['sales2'], data['sales3']))
            .toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Year')),
        legend: Legend(isVisible: true),
        series: <StackedBarSeries<SalesData, String>>[
          StackedBarSeries<SalesData, String>(
            dataSource: _data,
            xValueMapper: (SalesData sales, _) => sales.month,
            yValueMapper: (SalesData sales, _) => sales.sales1,
            name: 'Issued',
          ),
          StackedBarSeries<SalesData, String>(
            dataSource: _data,
            xValueMapper: (SalesData sales, _) => sales.month,
            yValueMapper: (SalesData sales, _) => sales.sales2,
            name: 'Retired',
          ),
          StackedBarSeries<SalesData, String>(
            dataSource: _data,
            xValueMapper: (SalesData sales, _) => sales.month,
            yValueMapper: (SalesData sales, _) => sales.sales3,
            name: 'Remaining',
          ),
        ],
        isTransposed: true);
  }
}

class SalesData {
  SalesData(this.month, this.sales1, this.sales2, this.sales3);

  final String month;
  final double sales1;
  final double sales2;
  final double sales3;
}
