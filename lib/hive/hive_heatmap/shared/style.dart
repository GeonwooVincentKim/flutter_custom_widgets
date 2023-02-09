// Get Background Colors
import 'package:flutter/material.dart';

const Color backgroundColor = Color.fromRGBO(189, 183, 183, 100);

// Get Button Colors
const Color buttonColor = Color.fromRGBO(217, 217, 217, 100);
const Color swipeIconColor = Color.fromRGBO(126, 126, 126, 100);
const Color plusIconColor = Color.fromRGBO(82, 82, 82, 100);

const Color transparentColor = Color.fromRGBO(255, 255, 255, 0);

const Color buttonTextColor = Color.fromARGB(255, 0, 0, 0);

// Get Button Border
const List<double> buttonBorder = [0, 10, 20, 30, 40, 50];

// Get padding between Buttons
const List<double> verticalList = [5, 10, 20, 30, 40, 50];
EdgeInsets verticalBigPadding = EdgeInsets.symmetric(vertical: verticalList[3]);
EdgeInsets verticalNormalPadding = EdgeInsets.symmetric(vertical: verticalList[1]);
EdgeInsets verticalSmallPadding = EdgeInsets.symmetric(vertical: verticalList[0]);

// Get ElevatedButton Box Size
const fixedTargetAmount = Size(130, 30);
const fixedDailyOutlays = Size(130, 40);

// Text Style
const sumTextStyle = TextStyle(color: buttonTextColor, fontSize: 25);
