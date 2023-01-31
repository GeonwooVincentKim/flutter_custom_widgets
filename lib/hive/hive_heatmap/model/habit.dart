import 'package:hive_flutter/hive_flutter.dart';

// reference our box
final _myBox = Hive.box("habit_db");

/*
  Data Structure

  _myBox.get("yyyymmdd") -> habitList
  _myBox.get("START_DATE") -> yyyymmdd
  _myBox.get("CURRENT_HABIT_LIST") -> latest habit list
  _myBox.get("PERCENTAGE_SUMMARY_yyyymmdd") -> 0.0 ~ 1.0 (HeatMap Color opacity)
*/

class Habit {
  List todaysHabitList = [];

  // create initial default data
  void createDefaultData() {
    todaysHabitList = [
      ["Run", false],
      ["Read", false]
    ];
  }

  // load data if it already exists
  void loadData() {

  }

  // update database
  void updateDatabase() {

  }
}

