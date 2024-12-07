import 'package:flutter/material.dart';
import 'src/train_code/train_main.dart'; // train_main.dart import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // train_main.dart의 TrainInfoScreen으로 네비게이트
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TrainInfoScreen()),
            );
          },
          child: const Text('기차 스케쥴링'),
        ),
      ),
    );
  }
}
