import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertBox extends StatelessWidget {
  final controller;
  final String hintText;
  final bool hasSumValue;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const CustomAlertBox({
    super.key, 
    required this.controller, 
    required this.hintText,
    required this.hasSumValue,
    required this.onSave, 
    required this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return hasSumValue == true ? 
      CupertinoAlertDialog(
        content: CupertinoTextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: CupertinoColors.black),
          // decoration: InputDecoration(
          //   hintText: hintText,
          //   hintStyle: TextStyle(color: Colors.grey[600]),
          //   enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          //   focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white))
          // ),
          placeholder: hintText,
          // onSubmitted: (_) => submit(context),
        ),
        actions: [
          TextButton(
            onPressed: onSave,
            child: const Text("Save")
          ),
          TextButton(
            onPressed: onCancel,
            child: const Text("Cancel")
          )
        ],
      ) : CupertinoAlertDialog(
        content: const Text("Please set the target amount"),
        actions: [
          TextButton(
            onPressed: onCancel,
            child: const Text("Go Back")
          )
        ],
      );
  }

  void submit(BuildContext context) {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }
}
