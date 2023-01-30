import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/app_screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage()
    );
  }
}
