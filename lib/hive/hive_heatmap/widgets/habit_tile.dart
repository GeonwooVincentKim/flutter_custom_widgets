import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MoneyTile extends StatelessWidget {
  final String moneyName;
  // final Function(bool?)? onChanged;
  // final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;

  const MoneyTile({
    super.key, 
    required this.moneyName, 
    // required this.onChanged, 
    // required this.settingsTapped, 
    required this.deleteTapped
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            // settings option
            // SlidableAction(
            //   onPressed: settingsTapped,
            //   backgroundColor: Colors.grey.shade800,
            //   icon: Icons.settings,
            //   borderRadius: BorderRadius.circular(12),
            // ),

            // delete option
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: CupertinoColors.systemRed,
              icon: CupertinoIcons.delete,
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
              // money name
              Text(moneyName),
              const SizedBox(width: 50),
              ElevatedButton(
                onPressed: () => false,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: CupertinoColors.quaternarySystemFill,
                  backgroundColor: Colors.transparent
                ),
                child: const Icon(Icons.arrow_back_ios, color: CupertinoColors.systemGrey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
