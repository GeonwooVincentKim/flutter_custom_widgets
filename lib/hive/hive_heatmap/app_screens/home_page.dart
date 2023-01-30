import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // data structure for todays list
  List todaysHabitList = [
    // [ habitName, habitCompleted ]
    ["Morning Run", false],
    ["Read Book", false],
  ];

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: ListView.builder(
        itemCount: todaysHabitList.length,
        itemBuilder:(context, index) {
          return HabitTile(
            habitName: todaysHabitList[index][0],
            habitCompleted: todaysHabitList[index][1], 
            onChanged: (value) => checkBoxTapped(value, index)
          );
        },
      )
    );
  }
}