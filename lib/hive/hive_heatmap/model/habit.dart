import 'package:hive_flutter/hive_flutter.dart';

// reference our box
final _myBox = Hive.box("habit_db");

class Habit {
  List todaysHabitLIst = [];

  // create initial default data
  void createDefaultData() {

  }

  // load data if it already exists
  void loadData() {

  }

  // update database
  void updateDatabase() {

  }
}

