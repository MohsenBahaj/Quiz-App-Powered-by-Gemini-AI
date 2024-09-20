class QuizQuestion {
  final String text;
  final List<String> answers;

  QuizQuestion(this.text, this.answers);

  List getShuffledAnswers() {
    final List shuffledlist = List.of(answers);
    shuffledlist.shuffle();
    return shuffledlist;
  }
}
