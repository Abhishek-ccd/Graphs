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

class Areachart extends StatefulWidget {
  const Areachart({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _AreachartState createState() => _AreachartState();
}

class _AreachartState extends State<Areachart> {
  List<ChartData> _issued = [];
  List<ChartData> _retired = [];
  List<ChartData> _remaining = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://demo2585809.mockable.io/areachart'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // final dataList = List<Map<String, dynamic>>.from(jsonData);

      final issuedData = jsonData[0]
          .map((data) => ChartData(data['year'], data['value']))
          .toList();

      final retiredData = jsonData[1]
          .map((data) => ChartData(data['year'], data['value']))
          .toList();

      final remainingData = jsonData[2]
          .map((data) => ChartData(data['year'], data['value']))
          .toList();

      setState(() {
        _issued = List<ChartData>.from(issuedData);
        _retired = List<ChartData>.from(retiredData);
        _remaining = List<ChartData>.from(remainingData);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      legend: Legend(isVisible: true),
      series: <AreaSeries<ChartData, String>>[
        AreaSeries<ChartData, String>(
          dataSource: _issued,
          xValueMapper: (ChartData data, _) => data.year,
          yValueMapper: (ChartData data, _) => data.value,
          name: 'Issued',
        ),
        AreaSeries<ChartData, String>(
          dataSource: _retired,
          xValueMapper: (ChartData data, _) => data.year,
          yValueMapper: (ChartData data, _) => data.value,
          name: 'Retired',
        ),
        AreaSeries<ChartData, String>(
          dataSource: _remaining,
          xValueMapper: (ChartData data, _) => data.year,
          yValueMapper: (ChartData data, _) => data.value,
          name: 'Remaining',
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.year, this.value);

  final String year;
  final double value;
}
