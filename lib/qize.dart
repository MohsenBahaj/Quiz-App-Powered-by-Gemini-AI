import 'package:flutter/material.dart';
import 'package:quiz/Components/spacer.dart';
import 'package:quiz/display_result.dart';
import 'package:quiz/questions.dart';
import 'package:quiz/quizquestions.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class QuizScreen extends StatefulWidget {
  final List<QuizQuestion> data;
  QuizScreen({super.key, required this.data});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int i = 0;
  final List<String> answers = [];

  final List<String> answersResult = [];

  void calcResult() {
    for (int j = 0; j < questions.length; j++) {
      if (widget.data[j].answers[0] == answers[j]) {
        answersResult.add('true');
      } else {
        answersResult
            .add('false, the correct answer is ${widget.data[j].answers[0]}');
      }
    }
    answersResult.add('end');

    // Navigate to result page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Result(answers: answersResult),
      ),
    );
  }

  void nextQuestion(String selectedAnswer) {
    answers.add(selectedAnswer);

    setState(() {
      if (i < questions.length - 1) {
        i++;
      } else {
        // Calculate the results and navigate
        calcResult();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // var currentQuestion = QuizQuestion.getShuffledAnswers();
    var currentQuestion = widget.data[i];
    final List shuffledlist = List.of(widget.data);
    shuffledlist.shuffle();

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurpleAccent, Colors.purpleAccent],
        ),
      ),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                decoration: TextDecoration.none,
                color: Colors.white,
              ),
            ),
            spacer(size: 20),
            for (var answer in currentQuestion.getShuffledAnswers())
              answerButton(
                text: answer,
                onpressed: () {
                  nextQuestion(answer);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class answerButton extends StatelessWidget {
  final String text;
  final void Function()? onpressed;

  const answerButton({
    super.key,
    required this.text,
    this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple[900],
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      ),
    );
  }
}
