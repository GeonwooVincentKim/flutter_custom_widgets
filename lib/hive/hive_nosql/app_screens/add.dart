import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/hive/hive_nosql/model/word_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String engWord = '';
  String korWord = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add")),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        engWord = value;
                      },
                      decoration: const InputDecoration(
                        labelText: '영어 단어'
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        korWord = value;
                      },
                      decoration: const InputDecoration(
                        labelText: '한글 단어'
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final box = await Hive.openBox<WordModel>("word");

                        int id = 0;

                        if (box.isNotEmpty) {
                          // Get the last item from the list
                          final prevItem = box.getAt(box.length - 1);

                          if (prevItem != null) {
                            id = prevItem.id + 1;
                          }
                        }

                        box.put(
                          id,
                          WordModel(
                            id: id,
                            engWord: engWord,
                            korWord: korWord,
                            correctCount: 0
                          )
                        );

                        Navigator.of(context).pop();
                      },
                      child: const Text("저장"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}