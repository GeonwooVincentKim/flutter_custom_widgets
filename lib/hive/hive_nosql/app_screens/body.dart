import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/hive/hive_nosql/app_screens/add.dart';
import 'package:flutter_custom_widgets/hive/hive_nosql/model/word_model.dart';
import 'package:flutter_custom_widgets/hive/hive_nosql/widgets/word_card.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Title"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder(
          valueListenable: Hive.box<WordModel>("word").listenable(),
          builder: (context, Box<WordModel> box, child) {
            return ListView.separated(
              itemBuilder: (_, index) {
                final item = box.getAt(index);

                if (item == null) {
                  return Container(
                    child: const Text("Item does not exist"),
                  );
                } else {
                  return WordCard(
                    onBodyTap: () {},
                    onCheckTap: () {},
                    engWord: item.engWord,
                    korWord: item.korWord,
                    correctCount: 0
                  );
                }
              },
              separatorBuilder: (_, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(),
                );
              },
              itemCount: box.length
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddScreen())
          );
        },
        child: const Icon(
          Icons.add
        )
      ),
    );
  }
}
