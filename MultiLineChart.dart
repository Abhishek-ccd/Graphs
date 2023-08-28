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

class Widget1 extends StatefulWidget {
  const Widget1({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _Widget1State createState() => _Widget1State();
}

class _Widget1State extends State<Widget1> {
  List<DeltaBlue> _issued = [];
  List<DeltaBlue> _retired = [];
  List<DeltaBlue> _remaining = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://demo3803644.mockable.io/data/'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // final dataList = List<Map<String, dynamic>>.from(jsonData);

      final issuedData = jsonData[0]
          .map((data) => DeltaBlue(data['year'], data['data']))
          .toList();

      final retiredData = jsonData[1]
          .map((data) => DeltaBlue(data['year'], data['data']))
          .toList();

      final remainingData = jsonData[2]
          .map((data) => DeltaBlue(data['year'], data['data']))
          .toList();

      setState(() {
        _issued = List<DeltaBlue>.from(issuedData);
        _retired = List<DeltaBlue>.from(retiredData);
        _remaining = List<DeltaBlue>.from(remainingData);
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
      series: <LineSeries<DeltaBlue, String>>[
        LineSeries<DeltaBlue, String>(
          dataSource: _issued,
          xValueMapper: (DeltaBlue sales, _) => sales.year,
          yValueMapper: (DeltaBlue sales, _) => sales.data,
          name: 'Issued',
        ),
        LineSeries<DeltaBlue, String>(
          dataSource: _retired,
          xValueMapper: (DeltaBlue sales, _) => sales.year,
          yValueMapper: (DeltaBlue sales, _) => sales.data,
          name: 'Retired',
        ),
        LineSeries<DeltaBlue, String>(
          dataSource: _remaining,
          xValueMapper: (DeltaBlue sales, _) => sales.year,
          yValueMapper: (DeltaBlue sales, _) => sales.data,
          name: 'Remaining',
        ),
      ],
    );
  }
}

class DeltaBlue {
  DeltaBlue(this.year, this.data);

  final String year;
  final double data;
}
