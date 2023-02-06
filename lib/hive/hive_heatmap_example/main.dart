import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap_example/heat_map.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Map<DateTime, int> getData = {DateTime(2023, 02, 06) : 1};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(child: MyHeatMap(setDataSet: getData))
      )
    );
  }
}
