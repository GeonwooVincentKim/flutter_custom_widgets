import 'package:flutter_custom_widgets/hive/hive_heatmap/shared/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

// reference our box
final _myBox = Hive.box("money_db");

/*
  Data Structure

  _myBox.get("yyyymmdd") -> moneyList
  _myBox.get("START_DATE") -> yyyymmdd
  _myBox.get("CURRENT_MONEY_LIST") -> latest money list
  _myBox.get("PERCENTAGE_SUMMARY_yyyymmdd") -> 0.0 ~ 1.0 (HeatMap Color opacity)
*/

class Money {
  List todayMoneyList = [];
  Map<DateTime, int> heatMapDateSet = {};
  int targetSum = 0;
  int dailySum = 0;
  String sign = '+';

  // create initial default data
  void createDefaultData() {
    todayMoneyList = [];
    _myBox.put("START_DATE", todaysDateFormatted());
  }

  // load data if it already exists
  void loadData() {
    // if it's a new day, get money list from database
    if (_myBox.get(todaysDateFormatted()) == null) {
    }
    
    // if it's not a new day, load todays list
    else {
      todayMoneyList = _myBox.get(todaysDateFormatted());
      dailySum = _myBox.get("DAILY_SUM");
      targetSum = _myBox.get("TARGET_SUM");
    }
  }

  // update database
  void updateDatabase() {
    // update todays entry
    _myBox.put(todaysDateFormatted(), todayMoneyList);

    // update universal money list in case it changed (new money, edit money, delete money)
    _myBox.put("CURRENT_MONEY_LIST", todayMoneyList);
    _myBox.put("DAILY_SUM", dailySum);
    _myBox.put("TARGET_SUM", targetSum);

    // calculate money complete percentages for each day
    calculateMoneyPercentages();

    // load heat map
    loadHeatMap();
  }

  void calculateMoneyPercentages() {
    _myBox.get("DAILY_SUM");
    _myBox.get("TARGET_SUM");

    print(dailySum);
    print(targetSum);
    // _myBox.put("DAILY_SUM", dailySum);

    String percent = '';
    
    if (todayMoneyList.isEmpty) {
      percent = '0.0';
    } else {
      if (dailySum <= targetSum) {
        percent = (dailySum / targetSum).toStringAsFixed(1);
        print("uP -> $percent");
      } else {
        percent = (targetSum / dailySum).toStringAsFixed(1);
        print("down -> $percent");
      }
    }

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

