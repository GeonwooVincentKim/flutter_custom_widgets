import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/hive/hive_nosql/app_screens/add.dart';
import 'package:flutter_custom_widgets/hive/hive_nosql/widgets/word_card.dart';

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
        child: ListView.separated(
          itemBuilder: (_, index) {
            return WordCard(
              onBodyTap: () {},
              onCheckTap: () {},
              engWord: 'test',
              korWord: '테스트',
              correctCount: 0
            );
          },
          separatorBuilder: (_, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(),
            );
          },
          itemCount: 50
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
