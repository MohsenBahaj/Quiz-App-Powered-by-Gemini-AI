import 'package:flutter/material.dart';
import 'package:quiz/home.dart';
import 'package:quiz/quiz_gen.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepPurpleAccent, Colors.purpleAccent])),
            child: Ai()),
      ),
    );
  }
}
