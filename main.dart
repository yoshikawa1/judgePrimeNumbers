import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    outputSummary = "初期表示";

    super.initState();
  }

  void _judgePrimeNumbers(String inputText) {
    setState(() {
      int input = int.parse(inputText);
      int counter = 0;
      var list = <int>[];
      for (int i = 1; i <= input; i++) {
        if (input % i == 0) {
          counter++;
          list.add(i);
        }
      }
      if (counter == 2) {
        outputSummary = '$inputText  は素数です';
      } else {
        outputSummary = '$inputText  は素数ではありません';
      }
      outputList = '役数は $list';
    });
  }

  void _clear() {
    setState(() {
      outputSummary = '';
      outputList = '';
    });
  }

  late String outputSummary;
  String outputList = '';
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('素数判定'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(fontSize: 20),
              controller: myController,
              decoration: const InputDecoration(
                hintText: '正の整数を入力してください',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'テキストを入力してください';
                } else {
                  if (RegExp(r'^[1-9]{1}[0-9]*$').hasMatch(value.trim())) {
                    return null;
                  } else {
                    return '正の整数を入力してください';
                  }
                }
              },
            ),
            ElevatedButton(
              child: const Text('素数判定'),
              onPressed: () {
                final input = myController.text;
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save(); // TextFormFieldのonSavedが呼び出される
                  _judgePrimeNumbers(input);
                } else {
                  _clear();
                }
              },
            ),
            Text(outputSummary, style: const TextStyle(fontSize: 20)),
            Text(outputList, style: const TextStyle(fontSize: 20))
          ],
        ),
      ),
    );
  }
}
