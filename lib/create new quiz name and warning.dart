import 'package:flutter/material.dart';
import 'package:students_quiz/quizzes%20static.dart';

import 'create new quiz layout.dart';

class NameNewQuizAndWarning extends StatefulWidget {
  const NameNewQuizAndWarning({Key? key}) : super(key: key);

  @override
  State<NameNewQuizAndWarning> createState() => _NameNewQuizAndWarningState();
}

class _NameNewQuizAndWarningState extends State<NameNewQuizAndWarning> {
  TextEditingController nameQuizController = TextEditingController();
  String DONT_LEAVE_BEFORE_FINISHING = "Do not save the quiz unless you're "
      "completely done adding questions and answers, "
      "questions are saved all at once and not separately.";
  final formKey = GlobalKey<FormState>();
  String QUESTION_KEY = "question";
  String CORRECT_ANSWER_KEY = "correct answer";
  String FIRST_WRONG_ANSWER_KEY = "first wrong answer";
  String SECOND_WRONG_ANSWER_KEY = "second wrong answer";
  List<SingleQuizItem> fullQuiz = [];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.blue,
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 100,
            width: double.infinity,
            color: Colors.blue,
            child: const Center(
              child: Text(
                "Name the new quiz",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
          resetPassBox(),
          warningBox(),
        ],
      ),
    ));
  }
  


  Widget warningBox() {
    return Center(
        child: Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 9,
          ),
        ],
      ),
      child: Text(
        DONT_LEAVE_BEFORE_FINISHING,
        style: TextStyle(color: Colors.white),
      ),
    ));
  }

  Widget resetPassBox() {
    return Center(
      child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 9,
              ),
            ],
          ),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: nameQuizController,
                      validator: (value) => value != null && value.length < 2
                          ? "Max 20 chars."
                          : null,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.quiz_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "Quiz name",
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: FloatingActionButton.extended(
                      label: Text(
                        "GO",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      onPressed: () => navigateToCreateNewQuiz(
                          nameQuizController.text.trim()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ))),
    );
  }

  void navigateToCreateNewQuiz(String quizName) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CreateNewQuizAdmin(nameQuizController.text.trim())),
    );
  }
}
