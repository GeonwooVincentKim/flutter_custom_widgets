import 'package:flutter_custom_widgets/hive/hive_heatmap/shared/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("custom_money_db");

class CustomMoney {
  List customMoneyList = [];
  Map<DateTime, int> heatMapDataSet = {};

  void createDefaultData() {
    customMoneyList = [];
    _myBox.put("START_DATE", todaysDateFormatted());
  }

  void loadData() {
    if (_myBox.get(todaysDateFormatted()) == null) {
      customMoneyList = _myBox.get("CURRENT_MONEY_LIST");

      for (int i = 0; i < customMoneyList.length; i++) {
        customMoneyList[i][1] = false;
      }
    } else {
      customMoneyList = _myBox.get(todaysDateFormatted());
    }
  }

  void updateDatabase() {
    _myBox.put(todaysDateFormatted(), customMoneyList);
    _myBox.put("CURRENT_MONEY_LIST", customMoneyList);

    calculateMoneyPercentages();
    loadHeatMap();
  }

  void calculateMoneyPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < customMoneyList.length; i++) {
      if (customMoneyList[i][1] == true) {
        countCompleted++;
      }
    }

    String percent = customMoneyList.isEmpty ? '0.0' : (countCompleted / customMoneyList.length).toStringAsFixed(1);
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    int daysIntBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysIntBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(startDate.add(Duration(days: i)));
      double strengthAsPercent = double.parse(_myBox.get("PERCENTAGE_SUMMARY_${yyyymmdd}") ?? "0.0");

      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final Map<DateTime, int> percentForEachDay = {DateTime(year, month, day) : (10 * strengthAsPercent).toInt()};
      heatMapDataSet.addEntries(percentForEachDay.entries);

      print(heatMapDataSet);
    }
  }
}
