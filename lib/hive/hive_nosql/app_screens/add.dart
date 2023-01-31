import 'package:flutter/material.dart';

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
                      onPressed: () {},
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