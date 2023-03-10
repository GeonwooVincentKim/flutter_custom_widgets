import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NewMoneyList extends StatelessWidget {
  final String moneyName;
  final bool moneyChecked;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  const NewMoneyList({super.key, required this.moneyName, required this.moneyChecked, this.onChanged, this.settingsTapped, this.deleteTapped});

  @override
 Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            // settings option
            SlidableAction(
              onPressed: settingsTapped,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
              borderRadius: BorderRadius.circular(12),
            ),

            // delete option
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.red.shade400,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // check box
              Checkbox(
                value: moneyChecked, 
                onChanged: onChanged
              ),
      
              // habit name
              Text(moneyName),
            ],
          ),
        ),
      ),
    );
  }
}