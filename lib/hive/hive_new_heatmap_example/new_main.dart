import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/hive/hive_new_heatmap_example/screens/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("custom_money_db");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "New HeatMap Example",
      theme: ThemeData.light(),
      home: const Home(),
    );
  }
}
