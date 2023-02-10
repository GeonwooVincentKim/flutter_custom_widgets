import 'package:flutter/cupertino.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/app_screens/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // initialize hive
  await Hive.initFlutter();

  // open a box
  await Hive.openBox("habit_db");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: CupertinoThemeData(primaryColor: CupertinoColors.activeGreen)
    );
  }
}
