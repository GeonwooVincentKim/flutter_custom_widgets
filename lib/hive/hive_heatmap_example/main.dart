import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap_example/heat_map.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(child: MyHeatMap())
      )
    );
  }
}
