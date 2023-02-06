import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  MyHeatMap({super.key});
  DateTime nowDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      defaultColor: Colors.white,
      colorMode: ColorMode.color,
      showText: false,
      scrollable: true,
      datasets: {
        // Colors light one if close to 1, Otherwise, colors dark one
        DateTime(2023, 2, 6): 1,
        DateTime(2023, 2, 7): 5,
        DateTime(2023, 2, 8): 5,
        DateTime(2023, 2, 9): 13,
        DateTime(2023, 2, 13): 6,
      },
      startDate: DateTime(nowDate.year, nowDate.month, 1),
      endDate: DateTime.now().add(Duration(days: 40)),
      size: 40,
      textColor: Colors.white,
      colorsets: const {
        // 1: Colors.red,
        // 3: Colors.orange,
        // 5: Colors.yellow,
        // 7: Colors.green,
        // 9: Colors.blue,
        // 11: Colors.indigo,
        // 13: Colors.purple,
        1: Color.fromARGB(20, 2, 179, 8),
        2: Color.fromARGB(40, 2, 179, 8),
        3: Color.fromARGB(60, 2, 179, 8),
        4: Color.fromARGB(80, 2, 179, 8),
        5: Color.fromARGB(100, 2, 179, 8),
        6: Color.fromARGB(120, 2, 179, 8),
        7: Color.fromARGB(150, 2, 179, 8),
        8: Color.fromARGB(180, 2, 179, 8),
        9: Color.fromARGB(220, 2, 179, 8),
        10: Color.fromARGB(255, 2, 179, 8),
      },
      // onClick: (value) {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
      // },
    );
  }
}