import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/app_screens/my_floating_action_button.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/custom_alertbox.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/habit_tile.dart';
import 'package:flutter_custom_widgets/hive/hive_heatmap/widgets/month_summary.dart';
import 'package:flutter_custom_widgets/hive/hive_new_heatmap_example/model/custom_money.dart';
import 'package:flutter_custom_widgets/hive/hive_new_heatmap_example/widgets/custom_monthly_summary.dart';
import 'package:flutter_custom_widgets/hive/hive_new_heatmap_example/widgets/custom_new_alert_dialogbox.dart';
import 'package:flutter_custom_widgets/hive/hive_new_heatmap_example/widgets/new_money_list.dart';
import 'package:hive/hive.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CustomMoney db = CustomMoney();
  final _myBox = Hive.box("custom_money_db");

  final _newMoneyElementController = TextEditingController();

  @override
  void initState() {
    if (_myBox.get("CURRENT_MONEY_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }

    db.updateDatabase();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HeatMap Calendar")),
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFloatingActionButton(onPressed: createNewMoney),
      body: ListView(
        children: [
          CustomMonthlySummary(datasets: db.heatMapDataSet, startDate: _myBox.get("START_DATE")),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.customMoneyList.length,
            itemBuilder: (context, index) {
              return NewMoneyList(
                moneyName: db.customMoneyList[index][0],
                moneyChecked: db.customMoneyList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                settingsTapped: (context) => openMoneySettings(index),
                deleteTapped: (context) => deleteMoney(index),
              );
            },
          )
        ],
      ),
    );
  }

  void checkBoxTapped(bool? value, int index) {
    setState(() => db.customMoneyList[index][1] = value);
    db.updateDatabase();
  }

  void createNewMoney() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomNewAlertDialogBox(
          controller: _newMoneyElementController,
          hintText: "Enter Money",
          onSave: saveNewMoney,
          onCancel: cancelDialogBox
        );
      }
    );
  }

  void saveNewMoney() {
    setState(() => db.customMoneyList.add([_newMoneyElementController.text, false]));
    _newMoneyElementController.clear();

    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void cancelDialogBox() {
    _newMoneyElementController.clear();
    Navigator.of(context).pop();
  }

  void openMoneySettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomNewAlertDialogBox(
          controller: _newMoneyElementController,
          hintText: db.customMoneyList[index][0],
          onSave: () => saveExistingMoney(index),
          onCancel: cancelDialogBox,
        );
      }
    );
  }

  void saveExistingMoney(int index) {
    setState(() => db.customMoneyList[index][0] = _newMoneyElementController.text);
    _newMoneyElementController.clear();

    Navigator.pop(context);
    db.updateDatabase();
  }

  void deleteMoney(int index) {
    setState(() => db.customMoneyList.removeAt(index));
    db.updateDatabase();
  }
}