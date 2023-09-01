// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

class Testing extends StatefulWidget {
  const Testing({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  List<Map<String, dynamic>> allLinesData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://demo3803644.mockable.io/new'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        setState(() {
          allLinesData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Invalid data type');
      }
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<LineSeries<Map<String, dynamic>, String>> seriesList = [];
    print("inside build");
    print(allLinesData);
    for (var item in allLinesData) {
      final lineName = item['line'] as String;
      final dataPoints = (item['data'] as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      print("inside for");
      print(dataPoints);
      seriesList.add(LineSeries<Map<String, dynamic>, String>(
        dataSource: dataPoints,
        xValueMapper: (data, _) => data['year'] as String,
        yValueMapper: (data, _) => data['data'] as double,
        name: lineName,
        markerSettings: MarkerSettings(isVisible: true),
      ));
    }
    ;
    print("here");
    print(seriesList);

    return SfCartesianChart(
      title: ChartTitle(text: 'Multi-Line Chart Example'),
      legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Year')),
      series: seriesList,
    );
  }
}