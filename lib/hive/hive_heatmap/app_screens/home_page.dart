import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/model/money.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/shared/style.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/custom/circle/custom_circle_avatar.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/custom/custom_alertbox.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/custom/custom_elevated_button.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/habit_tile.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/month_summary.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/custom/row/custom_row.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Money db = Money();
  final _myBox = Hive.box("money_db");

  int innerSum = 0;
  int targetSum = 0;
  bool? hasSumValue;
  
  final _newMoneyNameController = TextEditingController();
  final _newTargetAmountController = TextEditingController();

  @override
  void initState() {
    // if there is no current money list, then it is the 1st time ever opening the app
    // then create default data
    if (_myBox.get("CURRENT_money_LIST") == null) {
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
            createNewMoney(_newTargetAmountController, saveTargetAmount, cancelDialogBox);
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
            createNewMoney(_newMoneyNameController, saveNewMoney, cancelDialogBox);
          },
          child: const CustomCircleAvatar(backgroundColor: swipeIconColor, icon: Icons.add, iconColor: plusIconColor, size: 35)
        )
      ],
    );
  }

  // checkbox was tapped
  // void checkBoxTapped(bool? value, int index) {
  //   setState(() {
  //     db.todayMoneyList[index][1] = value;
  //   });
    
  //   db.updateDatabase();
  // }

  // create a new money
  void createNewMoney(controller, onSave, onCancel) {
    // show alert dialog for user to enter the new money details
    showCupertinoDialog(
      context: context, 
      builder: (context) {
        return CustomAlertBox(
          controller: controller,
          hintText: 'Enter Money Name',
          hasSumValue: (controller == _newMoneyNameController && db.targetSum <= 0) ? false : true,
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

  // save the new money
  void saveNewMoney() {
    // add new money to todays money list
    setState(() {
      db.todayMoneyList.add([_newMoneyNameController.text, false]);

      saveDifference(innerSum, '+');
      _myBox.put("INNER_SUM", innerSum);
    });

    // clear textfield
    _newMoneyNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
    db.updateDatabase();

  }

  // cancel the new money
  void cancelDialogBox() {
    // clear textfield
    _newMoneyNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
  }

  // open money setttings to edit
  // void openMoneySettings(int index) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return CustomAlertBox(
  //         controller: _newMoneyNameController,
  //         hintText: db.todayMoneyList[index][0],
  //         onSave: () => saveExistingMoney(index),
  //         onCancel: cancelDialogBox,
  //       );
  //     }
  //   );
  // }

  // save existing money with a new name
  // void saveExistingMoney(int index) {
  //   setState(() {
  //     db.todayMoneyList[index][0] = _newMoneyNameController.text;
  //   });

  //   _newMoneyNameController.clear();
    
  //   Navigator.of(context).pop();

  //   db.updateDatabase();
  // }

  // delete money
  void deleteMoney(int index) {
    setState(() {
      db.todayMoneyList.removeAt(index);

      // getSign('-');
      saveDifference(innerSum, '-');
      _myBox.put("INNER_SUM", innerSum);
    });

    db.updateDatabase();
  }

  void saveDifference(int innerSum, String sign) {
    for (int i = 0; i < db.todayMoneyList.length; i++) {
      if (sign == '+') {
        innerSum += int.parse(db.todayMoneyList[i][0]);
      } else if (sign == '-') {
        innerSum -= int.parse(db.todayMoneyList[i][0]);
      }
    }

    db.dailySum = innerSum.abs();
    // _myBox.put("INNER_SUM", innerSum);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.grey[300],
      // floatingActionButton: MyFloatingActionButton(onPressed: createNewMoney),
      child: Column(
        children: [
          _widgetTargetAmount(db.targetSum, true),

          // monthly summary heat map
          MonthlySummary(datasets: db.heatMapDateSet, startDate: _myBox.get("START_DATE")),

          // list of moneys
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: db.todayMoneyList.length,
              itemBuilder:(context, index) {
                return MoneyTile(
                  moneyName: db.todayMoneyList[index][0],
                  // moneyCompleted: db.todayMoneyList[index][1], 
                  // onChanged: (value) => checkBoxTapped(value, index),
                  // settingsTapped: (context) => openMoneySettings(index),
                  deleteTapped: (context) => deleteMoney(index),
                );
              },
            ),
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
