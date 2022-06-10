import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_quiz/edit%20quiz%20list.dart';
import 'package:students_quiz/login%20layout.dart';
import 'package:students_quiz/quizzes%20static.dart';

import 'Utils.dart';
import 'hex colors class.dart';
import 'main.dart';

class CreateNewQuizAdmin extends StatefulWidget {
  final String quizName;
  const CreateNewQuizAdmin(this.quizName, {Key? key}) : super(key: key);

  @override
  State<CreateNewQuizAdmin> createState() => _CreateNewQuizAdminState();
}

int _value = 1;
var QUESTION_TEXT = "Enter the question here...";
var CORRECT_ANSWER = "Enter the correct answer here...";
var FIRST_WRONG_ANSWER = "Enter a wrong answer here...";
const String schoolName = "TEXAS SCHOOL";
const String CREATE_NEW_QUIZ = "Create quiz: ";
const String register = "Register";
const String userName = "User Name - not implemented yet";
const String passWord = "Password";
const String EMAIL = "Email";
const String forgotPass = "Forgot Password";
const String ADD_NEW_QUIZ_QUESTION = "";
const String noAccountRegisterPlease = "Don't have an account?";
const String namePrefs = "";
const String ALREADY_HAVE_ACCOUNT = "Already have an account?";
const String USER_REGISTERED = "User registered successfully";
const String ADMIN_REGISTERED = "Admin registered successfully";
const String QUESTION_ADDED = "Question temporarily saved";
const String QUIZ_ADDED = "Quiz added successfully";
const String LOGIN = "Login";
final formKey = GlobalKey<FormState>();
String QUIZ_NAME_KEY = "quiz name";
String QUESTION_KEY = "question";
String QUESTION_NUMBER_KEY = "question number";
String CORRECT_ANSWER_KEY = "correct answer";
String FIRST_WRONG_ANSWER_KEY = "first wrong answer";
String SECOND_WRONG_ANSWER_KEY = "second wrong answer";
String FILL_FORM_CORRECTLY = "Please fill all the spaces";
String SAVE_QUIZ = "SAVE";
String NEXT_QUESTION = "NEXT";
List<SingleQuizItem> fullQuiz = [];
Color primColor = HexColor("#001f3e");
Color secondaryColor = Colors.white;
Color borderColor = Colors.white;
Color buttonColor = Colors.white;
int questionNumber = 1;
var totalQuestions = 50;
TextEditingController questionController = TextEditingController();
TextEditingController correctAnswerController = TextEditingController();
TextEditingController firstWrongAnswerController = TextEditingController();
TextEditingController secondWrongAnswerController = TextEditingController();

class _CreateNewQuizAdminState extends State<CreateNewQuizAdmin> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.blue,
      child: ListView(
        children: <Widget>[
          newQuizFormLayout(),
          bottomNavBox(),
        ],
      ),
    ));
  }

  @override
  void initState() {
    questionNumber = 1;
    super.initState();
  }



  Widget newQuizFormLayout() {
    return Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.blue, width: 1))),
                child: Text(
                  CREATE_NEW_QUIZ + widget.quizName,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 10, 0),
            alignment: Alignment.centerLeft,
            child: Text("Question no. $questionNumber"),
          ),
          Container(
              child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                      controller: questionController,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 4
                          ? "Create a question"
                          : null,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.question_mark),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: QUESTION_TEXT,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 1
                          ? "Create an answer"
                          : null,
                      controller: correctAnswerController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.gpp_good_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: CORRECT_ANSWER,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: firstWrongAnswerController,
                      validator: (value) => value != null && value.length < 1
                          ? "Create an answer"
                          : null,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.gpp_bad_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: FIRST_WRONG_ANSWER,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: secondWrongAnswerController,
                      validator: (value) => value != null && value.length < 1
                          ? "Create an answer"
                          : null,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.gpp_bad_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: FIRST_WRONG_ANSWER,
                      )),
                ),
              ],
            ),
          )),
          SizedBox(
            height: 30,
          )
        ]));
  }

  Widget questionNumberLayout() {
    return Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.white)),
        ),
        child: Row(
          children: <Widget>[
            Text(
              "Question $questionNumber",
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "/$totalQuestions",
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 20,
              ),
            )
          ],
        ));
  }

  Widget bottomNavBox() {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: saveQuestionBtn(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: doneWithQuiz(),
            )
          ]),
    );
  }

  Widget finishQuiz() {
    return FloatingActionButton.extended(
      label: const Text(
        "SUBMIT",
        style: TextStyle(color: Colors.black),
      ), // <-- Text
      backgroundColor: buttonColor,
      icon: Icon(
        Icons.save,
        color: Colors.black,
      ),
      onPressed: null,
    );
  }

  Widget saveQuestionBtn() {
    return FloatingActionButton.extended(
      backgroundColor: buttonColor,
      label: Text(
        NEXT_QUESTION,
        style: TextStyle(color: Colors.blue, fontSize: 16),
      ),
      icon: const Icon(
        // <-- Icon
        Icons.save, color: Colors.blue,
        size: 24.0,
      ),
      onPressed: singleButtonClick,
    );
  }

  void singleButtonClick() {
    Fluttertoast.cancel();
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      Fluttertoast.showToast(
          msg: FILL_FORM_CORRECTLY, backgroundColor: Colors.red);
      return;
    } else {
      enterQuizIntoDatabase();
    }
  }

  void enterQuizIntoDatabase() async {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: slider()),
    );

    Fluttertoast.cancel();
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      Fluttertoast.showToast(
          msg: FILL_FORM_CORRECTLY, backgroundColor: Colors.red);
      Navigator.pop(context);
      return;
    }

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No internet connection", backgroundColor: Colors.red);
      Navigator.pop(context);
      return;
    }

    try{
      await FirebaseFirestore.instance
          .collection("quizzes")
          .doc(widget.quizName).set({
        " " : " "
      }
      );

      await FirebaseFirestore.instance
          .collection("quizzes")
          .doc(widget.quizName)
          .collection(widget.quizName)
          .doc("$questionNumber")
          .set({
        (QUIZ_NAME_KEY): widget.quizName,
        (QUESTION_KEY): questionController.text.trim(),
        (QUESTION_NUMBER_KEY): questionNumber,
        (CORRECT_ANSWER_KEY): correctAnswerController.text.trim(),
        (FIRST_WRONG_ANSWER_KEY): firstWrongAnswerController.text.trim(),
        (SECOND_WRONG_ANSWER_KEY): secondWrongAnswerController.text.trim(),
      });
      Fluttertoast.showToast(msg: "Question saved", backgroundColor: Colors.green);
      questionController.clear();
      correctAnswerController.clear();
      firstWrongAnswerController.clear();
      secondWrongAnswerController.clear();
      questionNumber++;
      setState(() {});

    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), backgroundColor: Colors.red);
    }
    Navigator.pop(context);


  }

  Widget doneWithQuiz() {
    return FloatingActionButton.extended(
      backgroundColor: buttonColor,
      label: Text(
        SAVE_QUIZ,
        style: TextStyle(color: Colors.blue, fontSize: 18),
      ),
      icon: const Icon(
        // <-- Icon
        Icons.done, color: Colors.blue,
        size: 24.0,
      ),
      onPressed:
          () => navigatorKey.currentState!.popUntil((route) => route.isFirst)
      ,
    );
  }

}
