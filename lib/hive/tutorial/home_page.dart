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
    // _myBox.put(2, 'No.2');
    _myBox.put(2, ["Mitch", 26, 'Purple']);
  }

  // read data
  void readData() {
    print(_myBox.get(2));
  }

  // delete data
  void deleteData() {
    _myBox.delete(1);
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
