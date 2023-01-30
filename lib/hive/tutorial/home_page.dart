import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // refernce our box
  final _myBox = Hive.box("tutorial_box");

  // write data
  void writeData() {
    _myBox.put(1, 'No.1');
  }

  // read data
  void readData() {
    print(_myBox.get(1));
  }

  // delete data
  void deleteData() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: writeData,
              color: Colors.blue[200],
              child: const Text("Write")
            ),
            MaterialButton(
              onPressed: readData,
              color: Colors.blue[200],
              child: const Text("Read")
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.blue[200],
              child: const Text("Delete")
            )
          ],
        ),
      )
    );
  }
}
