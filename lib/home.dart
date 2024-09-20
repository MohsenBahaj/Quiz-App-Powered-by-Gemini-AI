import 'package:flutter/material.dart';
import 'package:quiz/Components/spacer.dart';
import 'package:quiz/qize.dart';
import 'package:quiz/quizquestions.dart';

//AIzaSyDgPKmCXQWi5SAm3fPpsJODkbIOGyr4CUQ
class MainPage extends StatefulWidget {
  final List<QuizQuestion> data;
  const MainPage({super.key, required this.data});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.purpleAccent])),
      child: Center(
          child: Column(
        children: [
          spacer(size: 40),
          Image.asset(
            'images/quiz-logo.png',
            height: 350,
          ),
          spacer(size: 100),
          Text(
            'Learn Flutter',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          spacer(size: 40),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (c) => QuizScreen(
                        data: widget.data,
                      )));
            },
            child: Text('Start Quiz'),
            style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Colors.white))),
                textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 20)),
                foregroundColor: WidgetStateProperty.all(Colors.white)),
          ),
        ],
      )),
    );
  }
}
