import 'package:flutter_custom_widgets/hive/hive_heatmap/shared/date_time.dart';
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
  Map<DateTime, int> heatMapDateSet = {};
  int targetSum = 90000;

  // create initial default data
  void createDefaultData() {
    todaysHabitList = [
      // ["Run", false],
      // ["Read", false]
    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }

  // load data if it already exists
  void loadData() {
    // if it's a new day, get habit list from database
    if (_myBox.get(todaysDateFormatted()) == null) {
      // todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
    
      // // set all habit completed to false since it's a new day
      // for (int i = 0; i < todaysHabitList.length; i++) {
      //   todaysHabitList[i][1] = false;
      // }
    }
    
    // if it's not a new day, load todays list
    else {
      todaysHabitList = _myBox.get(todaysDateFormatted());
    }
  }

  // update database
  void updateDatabase() {
    // update todays entry
    _myBox.put(todaysDateFormatted(), todaysHabitList);

    // update universal habit list in case it changed (new habit, edit habit, delete habit)
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);

    // calculate habit complete percentages for each day
    calculateHabitPercentages();

    // load heat map
    loadHeatMap();
  }

  void calculateHabitPercentages() {
    // int countCompleted = 0;
    // for (int i = 0; i < todaysHabitList.length; i++) {
    //   countCompleted++;
    // }

    int innerSum = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      // print(db.moneyList[i][0].runtimeType); // Get current value's type
      print("Values -> ${int.parse(todaysHabitList[i][0])}");
      // print("Plus -> ${int.parse(db.moneyList[i][0]) + int.parse(db.moneyList[i][0])}");
    
      innerSum += int.parse(todaysHabitList[i][0]); // Store into the innerSum
    }    

    String percent = todaysHabitList.isEmpty 
      ? '0.0' 
      : (innerSum / targetSum).toStringAsFixed(1);

    // key: "PERCENTAGE_SUMMARY_yyyymmdd"
    // value: string of 1db number between 0.0 ~ 1.0 inclusive
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    // count the number of days to load
    int daysInBetweeen = DateTime.now().difference(startDate).inDays;

    // go from start date to today and add each percentage to the dataset
    // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
    for (int i = 0; i < daysInBetweeen + 1; i++) {
      String yyyymmdd = convertDateTimeToString(startDate.add(Duration(days: i)));
      double strengthAsPercent = double.parse(_myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0");

      // split the datatime up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int> {
        DateTime(year, month, day) : (10 * strengthAsPercent).toInt()
      };

      print(strengthAsPercent);
      print(percentForEachDay);

      heatMapDateSet.addEntries(percentForEachDay.entries);
      print(heatMapDateSet);
    }
  }
}

