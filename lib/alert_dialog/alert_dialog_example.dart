import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static String title = "AlertDialog Example";
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      actions: null,
      theme: ThemeData(brightness: Brightness.light),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController controller;
  String name = '';

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title.toString())
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Name: ',
                    style: TextStyle(fontWeight: FontWeight.bold)
                  )
                ),
                const SizedBox(width: 12),
                Text(name),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Open Dialog'),
                    onPressed: () async {
                      final name = await openDialog();

                      if (name == null || name.isEmpty) return;
                      setState(() => this.name = name);
                    },
                  ),
                ),
              ],
            ),
          ],
        )
        
      ),
    );
  }

  /*
    Future -> Only returns the form of showDialog
    Future<String?> -> Returns the String value that shows the result of showDialog input
   */
  Future<String?> openDialog() => showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Your Name'),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: "Enter your Name"),
        controller: controller,
        // Hide the Submit button if press Check button in Keyboard
        onSubmitted: (_) => submit(),
      ),
      actions: [
        TextButton(
          child: Text('SUBMIT'),
          onPressed: submit,
        )
      ],
    )
  );

  void submit() {
    Navigator.of(context).pop(controller.text);

    controller.clear();
  }
}
