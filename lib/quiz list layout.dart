import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_quiz/quiz%20question%20item%20layout.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class QuizListLayout extends StatefulWidget {
  const QuizListLayout({Key? key}) : super(key: key);

  @override
  State<QuizListLayout> createState() => _QuizListLayoutState();
}

const String CHOOSE_QUIZ = "Select a quiz";
var quizNamesArray = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25
];
Color primColor = Colors.blueAccent;
bool isAdmin = false;

class _QuizListLayoutState extends State<QuizListLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primColor,
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: primColor,
          ),
          selectQuizBox(),
          quizListBox(),
        ],
      ),
    );
  }

  Widget quizListBox() {
    return Container(
        margin: const EdgeInsets.all(20),
        height: 450,
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
              color: Colors.grey.withOpacity(0.75),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 8), // Shadow position
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: primColor),
              borderRadius: const BorderRadius.all(Radius.circular(50.0))),
          child: ListView.builder(
            itemCount: 25,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => ListTile(
                title: TextButton(
              child: Text(
                "Quiz #${quizNamesArray[index + 1]}",
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              onPressed: () => proceedToSelectedQuiz(index),
            )),
          ),
        ));
  }

  void proceedToSelectedQuiz(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            // builder: (context) => SpecificQuizInfo("Quiz #${index+1}")
            builder: (context) =>
                QuizQuestionLayout("Quiz #${index + 1}")));
  }

  Widget selectQuizBox() {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 100,
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
            color: Colors.grey.withOpacity(0.75),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 8), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(50.0))),
            child: Center(
              child: Container(
                  padding: const EdgeInsets.all(7),
                  child: const Text(
                    CHOOSE_QUIZ,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                    ),
                  )),
            ),
          ),
          Offstage(
            offstage: isAdmin,
            child: Text(
            "Logged in as Admin",
            style: const TextStyle(
              color: Colors.red,
              fontSize: 30,
            ),
          )
          )
        ],
      ),
    );
  }

  void backToDashboard() {
    Navigator.pop(context);
  }
}
