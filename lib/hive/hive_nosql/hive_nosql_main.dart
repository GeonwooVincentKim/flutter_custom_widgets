import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/hive/hive_nosql/app_screens/body.dart';
import 'package:flutter_custom_widgets/hive/hive_nosql/model/word_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WordModelAdapter());

  await Hive.openBox<WordModel>("word");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Body(),
    );
  }
}
