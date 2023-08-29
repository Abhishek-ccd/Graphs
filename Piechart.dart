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

class Piechart extends StatefulWidget {
  const Piechart({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _PiechartState createState() => _PiechartState();
}

class _PiechartState extends State<Piechart> {
  List<PollData> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://demo2585809.mockable.io/piechart'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _data =
            List<PollData>.from(data.map((item) => PollData.fromJson(item)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      legend: Legend(isVisible: true),
      series: <CircularSeries>[
        PieSeries<PollData, String>(
          dataSource: _data,
          xValueMapper: (PollData data, _) => data.option,
          yValueMapper: (PollData data, _) => data.percentage,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class PollData {
  PollData(this.option, this.percentage);

  final String option;
  final double percentage;

  factory PollData.fromJson(Map<String, dynamic> json) {
    return PollData(json['name'], json['percentage']);
  }
}
