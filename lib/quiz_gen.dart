import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quiz/Components/spacer.dart';
import 'package:quiz/home.dart';
import 'package:quiz/quizquestions.dart';

class Ai extends StatefulWidget {
  const Ai({super.key});

  @override
  State<Ai> createState() => _AiState();
}

class _AiState extends State<Ai> {
  TextEditingController _textEditingController = TextEditingController();

  Future<String?> quizGen(String title) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey:
          'AIzaSyDgPKmCXQWi5SAm3fPpsJODkbIOGyr4CUQ', // Add your API key here
    );

    final prompt = '''
Generate a list of 7 $title questions. Each question should have a maximum of 10 words, and the correct answer should be the first option. Format the output as plain text with questions separated by dots and options separated by commas. Do not include any brackets or parentheses. Example format:

What is the smallest unit of an element?, Atom, Molecule, Compound, Ion. What is the study of matter?, Chemistry, Physics, Biology, Geology.

Your output should follow this format exactly and should not include any additional characters or formatting.
''';

    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    // Ensure response.text is not null
    final responseText = response.text ?? '';
    print(responseText); // Inspect the response text to understand its format

    return responseText; // Return responseText so it can be used in onPressed
  }

  // Parse function to convert text into a list of QuizQuestion objects
  List<QuizQuestion> parseQuestions(String text) {
    final questions = <QuizQuestion>[];

    // Split the text by dots to separate each question
    final questionTextList =
        text.split('.').where((q) => q.trim().isNotEmpty).toList();

    for (final questionText in questionTextList) {
      final parts = questionText.split(',');

      if (parts.length >= 2) {
        final question = parts[0].trim();
        final options = parts.skip(1).map((option) => option.trim()).toList();

        if (options.isNotEmpty) {
          questions.add(QuizQuestion(question, options));
        }
      }
    }

    return questions;
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    if (isLoading) {
      return Center(
          child: LoadingAnimationWidget.twistingDots(
        leftDotColor: const Color(0xFF1A1A3F),
        rightDotColor: const Color(0xFFEA3799),
        size: 200,
      ));
    } else
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            cursorColor: const Color.fromARGB(255, 0, 0, 0),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(),
              hintText: 'Enter Quiz Title',
            ),
            controller: _textEditingController,
          ),
          spacer(size: 30),
          ElevatedButton(
            onPressed: () async {
              isLoading = true;
              setState(() {});
              // Call quizGen and get the response text
              final responseText = await quizGen(_textEditingController.text);

              // Initialize the data variable
              List<QuizQuestion> data = [];

              // Ensure responseText is not null
              if (responseText != null && responseText.isNotEmpty) {
                // Parse the response text to get the list of QuizQuestion
                data = parseQuestions(responseText);
              }
              setState(() {
                isLoading = false;
              });
              // Navigate to MainPage with the parsed data
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MainPage(data: data),
                ),
              );
            },
            child: const Text('Generate Quiz'),
          ),
        ]),
      );
  }
}
