import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/app_screens/my_floating_action_button.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/model/habit.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/shared/style.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/circle/custom_circle_avatar.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/custom_alertbox.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/habit_tile.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/month_summary.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/row/custom_elevated_button.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/row/custom_row.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Habit db = Habit();
  final _myBox = Hive.box("habit_db");

  int innerSum = 0;
  int targetSum = 0;
  
  final _newHabitNameController = TextEditingController();
  final _newTargetAmountController = TextEditingController();

  @override
  void initState() {
    // if there is no current habit list, then it is the 1st time ever opening the app
    // then create default data
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } 
    
    // there already exists data, this is not the first time
    else {
      db.loadData();
    }
    
    print(db.dailySum);

    // update the database
    db.updateDatabase();

    super.initState();
  }

  CustomRow _widgetTargetAmount(int targetSum, bool hasSumValue) {
    return CustomRow(
      children: [
        const SizedBox(width: 50),

        ElevatedButton(
          onPressed: () => false,
          child: Text("$targetSum"),
        ),

        const SizedBox(width:35),
        GestureDetector(
          onTap: () {
            createNewHabit(_newTargetAmountController, saveTargetAmount, cancelDialogBox);
          },
          child: const CustomCircleAvatar(backgroundColor: transparentColor, icon: Icons.credit_card, iconColor: buttonTextColor, size: 35),
        )
      ],
    );
  }

  CustomRow _widgetDailyOutlays(int dailySum) {
    return CustomRow(
      children: [
        const Text("하루지출"),
        const SizedBox(width: 20),

        ElevatedButton(
          onPressed: () => false,
          child: Text("$dailySum"),
        ),

        const SizedBox(width: 35),
        GestureDetector(
          onTap: () {
            createNewHabit(_newHabitNameController, saveNewHabit, cancelDialogBox);
          },
          child: const CustomCircleAvatar(backgroundColor: swipeIconColor, icon: Icons.add, iconColor: plusIconColor, size: 35)
        )
      ],
    );
  }

  // checkbox was tapped
  // void checkBoxTapped(bool? value, int index) {
  //   setState(() {
  //     db.todaysHabitList[index][1] = value;
  //   });
    
  //   db.updateDatabase();
  // }

  // create a new habit
  void createNewHabit(controller, onSave, onCancel) {
    // show alert dialog for user to enter the new habit details
    showDialog(
      context: context, 
      builder: (context) {
        return CustomAlertBox(
          controller: controller,
          hintText: 'Enter Habit Name',
          onSave: onSave,
          onCancel: onCancel,
        );
      }
    );
  }

  // save target expand
  void saveTargetAmount() {
    setState(() {
      db.targetSum = int.parse(_newTargetAmountController.text);
      _myBox.put("TARGET_SUM", targetSum);
    });
    db.updateDatabase();

    _newTargetAmountController.clear();
    Navigator.of(context).pop();
  }

  // save the new habit
  void saveNewHabit() {
    // add new habit to todays habit list
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);

      saveDifference(innerSum, '+');
      _myBox.put("INNER_SUM", innerSum);
    });

    // clear textfield
    _newHabitNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
    db.updateDatabase();

  }

  // cancel the new habit
  void cancelDialogBox() {
    // clear textfield
    _newHabitNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
  }

  // open habit setttings to edit
  // void openHabitSettings(int index) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return CustomAlertBox(
  //         controller: _newHabitNameController,
  //         hintText: db.todaysHabitList[index][0],
  //         onSave: () => saveExistingHabit(index),
  //         onCancel: cancelDialogBox,
  //       );
  //     }
  //   );
  // }

  // save existing habit with a new name
  // void saveExistingHabit(int index) {
  //   setState(() {
  //     db.todaysHabitList[index][0] = _newHabitNameController.text;
  //   });

  //   _newHabitNameController.clear();
    
  //   Navigator.of(context).pop();

  //   db.updateDatabase();
  // }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);

      // getSign('-');
      saveDifference(innerSum, '-');
      _myBox.put("INNER_SUM", innerSum);
    });

    db.updateDatabase();
  }

  void saveDifference(int innerSum, String sign) {
    for (int i = 0; i < db.todaysHabitList.length; i++) {
      if (sign == '+') {
        innerSum += int.parse(db.todaysHabitList[i][0]);
      } else if (sign == '-') {
        innerSum -= int.parse(db.todaysHabitList[i][0]);
      }
    }

    db.dailySum = innerSum.abs();
    // _myBox.put("INNER_SUM", innerSum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      body: ListView(
        children: [
          _widgetTargetAmount(db.targetSum, true),

          // monthly summary heat map
          MonthlySummary(datasets: db.heatMapDateSet, startDate: _myBox.get("START_DATE")),

          // list of habits
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabitList.length,
            itemBuilder:(context, index) {
              return HabitTile(
                habitName: db.todaysHabitList[index][0],
                habitCompleted: db.todaysHabitList[index][1], 
                // onChanged: (value) => checkBoxTapped(value, index),
                // settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [ 
                _widgetDailyOutlays(db.dailySum),
                CustomElevatedButton(getValue: "Google Ads", customFixedSize: Size(MediaQuery.of(context).size.width * 0.9, 60))
              ],
            ),
          ),
        ]
      )
    );
  }
}
