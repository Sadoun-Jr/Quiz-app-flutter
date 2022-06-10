class SingleQuizItem {

  String QUIZ_NAME_KEY = "quiz name";
  String QUESTION_KEY = "question";
  String QUESTION_NUMBER_KEY = "question number";
  String CORRECT_ANSWER_KEY = "correct answer";
  String FIRST_WRONG_ANSWER_KEY = "first wrong answer";
  String SECOND_WRONG_ANSWER_KEY = "second wrong answer";

  String quizName;
  String question;
  int questionNumber;
  String correctAnswer;
  String firstWrongAnswer;
  String secondWrongAnswer;

  SingleQuizItem(
    this.quizName,
    this.question,
    this.questionNumber,
    this.correctAnswer,
    this.firstWrongAnswer,
    this.secondWrongAnswer,
  );

  //So, later when you have a SingleQuizItem object,
  // you just can call SingleQuizItem.tomap().

  Map<String, dynamic> toMap() {
    return {
      QUIZ_NAME_KEY: quizName,
      QUESTION_KEY: question,
      QUESTION_NUMBER_KEY: questionNumber,
      CORRECT_ANSWER_KEY: correctAnswer,
      FIRST_WRONG_ANSWER_KEY: firstWrongAnswer,
      SECOND_WRONG_ANSWER_KEY: secondWrongAnswer,
    };

  }

  // SingleQuizItem.fromMap(Map<String, dynamic> map) {
  //   quizName = map[QUIZ_NAME_KEY];
  //   question = map[QUESTION_KEY];
  //   questionNumber = map[QUESTION_NUMBER_KEY];
  //   correctAnswer = map[CORRECT_ANSWER_KEY];
  //   firstWrongAnswer = map[FIRST_WRONG_ANSWER_KEY];
  //   secondWrongAnswer = map[SECOND_WRONG_ANSWER_KEY];
  // }
}

final List<SingleQuizItem> entireQuiz = [];
