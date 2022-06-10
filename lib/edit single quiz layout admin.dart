import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_quiz/admin%20dashboard.dart';
import 'package:students_quiz/quizzes%20static.dart';
import 'Utils.dart';
import 'main.dart';

class EditSingleQuizListOfQuestions extends StatefulWidget {
  final String quizName;
  const EditSingleQuizListOfQuestions(this.quizName, {Key? key})
      : super(key: key);

  @override
  State<EditSingleQuizListOfQuestions> createState() =>
      _EditSingleQuizListOfQuestionsState();
}

var number = 0;
Color primColor = Colors.blueAccent;
bool isAdmin = true;
const String EDIT_QUIZ = "Editting quiz: ";
const String CHOOSE_QUESTION_TO_EDIT = "Select a question to edit it";
const String ERROR_LOADING_DATA = "Error loading data, check connection";
const String LOADING_DATA = "Loading...";
const String DONE = "DONE  ";
const String DELETE_QUIZ = "DELETE";
const String EDIT_QUIZ_QUESTION = "Edit Question";
List<SingleQuizItem> entireDb = [];
int key = 0;
var entireDbArraySaved = [];
List<SingleQuizItem> filteredListOfQuestions = [];
var listOfQuestions = [];
var listOfCorrectAnswers = [];
var listOfFirstWrongAnswers = [];
var listOfSecondWrongAnswers = [];
String QUIZ_NAME_KEY = "quiz name";
String QUESTION_KEY = "question";
String QUESTION_NUMBER_KEY = "question number";
String CORRECT_ANSWER_KEY = "correct answer";
String FIRST_WRONG_ANSWER_KEY = "first wrong answer";
String SECOND_WRONG_ANSWER_KEY = "second wrong answer";
String FILL_FORM_CORRECTLY = "Please fill all the spaces";

var QUESTION_TEXT = "Enter the question here...";
var CORRECT_ANSWER = "Enter the correct answer here...";
var FIRST_WRONG_ANSWER = "Enter a wrong answer here...";

SingleQuizItem selectedQuestionToEdit = SingleQuizItem("", "", 0, "", "", "");

class _EditSingleQuizListOfQuestionsState
    extends State<EditSingleQuizListOfQuestions> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primColor,
      body: ListView(children: <Widget>[
        selectQuizBox(),
        quizListBox(),
        bottomNavBox(),
      ]),
    );
  }

  @override
  void initState() {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: "Refreshing Questions...");

    for (int i = 0; i < entireDb.length; i++) {
      if (entireDb[i].question == "werwerwer") {
        selectedQuestionToEdit = entireDb[i];
      }
    }

    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {});
    });
    super.initState();
  }

  navigateBackToQuizList() {
    Navigator.pop(context);
  }

  Widget bottomNavBox() {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: FloatingActionButtonBottom(
                  1, DELETE_QUIZ, Icons.delete, () {}, Colors.red),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButtonBottom(
                  2, DONE, Icons.done, () => {}, Colors.blue),
            ),
          ]),
    );
  }

  Widget FloatingActionButtonBottom(int heroTag, String text, IconData iconData,
      VoidCallback function, Color textClr) {
    return FloatingActionButton.extended(
      heroTag: heroTag,
      backgroundColor: Colors.white,
      label: Text(
        text,
        style: TextStyle(color: textClr, fontSize: 14),
      ),
      icon: Icon(
        // <-- Icon
        iconData, color: textClr,
        size: 24.0,
      ),
      onPressed: function,
    );
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
            color: Colors.black.withOpacity(0.75),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 4), // Shadow position
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
                child: RichText(
                  text: TextSpan(
                    text: EDIT_QUIZ,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.quizName,
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(50.0))),
            child: Center(
              child: Container(
                  padding: const EdgeInsets.all(7),
                  child: const Text(
                    CHOOSE_QUESTION_TO_EDIT,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18,
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
              ))
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
              color: Colors.black.withOpacity(0.75),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 4), // Shadow position
            ),
          ],
        ),
        child: contentsOfList());
  }

  Widget contentsOfList() {
    Stream<QuerySnapshot> quizzesCollectionStream =
        FirebaseFirestore.instance.collection("quizzes").snapshots();
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: primColor),
          borderRadius: const BorderRadius.all(Radius.circular(50.0))),
      child: StreamBuilder<QuerySnapshot>(
        stream: quizzesCollectionStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(ERROR_LOADING_DATA),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  slider(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(LOADING_DATA),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final result = FirebaseFirestore.instance.collection('quizzes');
            result.get().then((snapshot) {
              snapshot.docs.forEach((element) {
                entireDb.clear();
                getSingleQuizLoop(element.id.toString());
              });
            });
            return Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: filteredListOfQuestions.length,
                    itemBuilder: (context, index) => Column(
                          children: [
                            inkWellButton(index, () => {}),
                          ],
                        )));
          } else {
            return Center(
              child: Text("failure"),
            );
          }
        },
      ),
    );
  }

  void getSingleQuizLoop(String element) {
    entireDb.clear();
    FirebaseFirestore.instance
        .collection('quizzes')
        .doc(element)
        .collection(element)
        .orderBy(QUESTION_NUMBER_KEY, descending: false)
        .get()
        .then(((querySnapshot) {
      for (var element in querySnapshot.docs) {
        SingleQuizItem quizItem = SingleQuizItem(
          element.data()[QUIZ_NAME_KEY],
          element.data()[QUESTION_KEY],
          element.data()[QUESTION_NUMBER_KEY],
          element.data()[CORRECT_ANSWER_KEY],
          element.data()[FIRST_WRONG_ANSWER_KEY],
          element.data()[SECOND_WRONG_ANSWER_KEY],
        );
        entireDb.add(quizItem);
      }

      //add only questions to list them
      selectedQuestionToEdit = SingleQuizItem("", "", 8, "", "", "");
      filteredListOfQuestions.clear();
      for (int i = 0; i < entireDb.length; i++) {
        if (entireDb[i].quizName == widget.quizName) {
          filteredListOfQuestions.add(entireDb[i]);
        }
      }
    }));
  }

  var exampleEntireDb = [
    SingleQuizItem("quizName", "question", 3, "correctAnswer",
        "firstWrongAnswer", "secondWrongAnswer"),
    SingleQuizItem("quizName", "question", 3, "correctAnswer",
        "firstWrongAnswer", "secondWrongAnswer"),
    SingleQuizItem("quizName", "question", 3, "correctAnswer",
        "firstWrongAnswer", "secondWrongAnswer"),
  ];

  Widget inkWellButton(int index, VoidCallback? function) {
    return Container(
        child: SizedBox.fromSize(
      size: Size(double.infinity, 150),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: Material(
          color: (Colors.transparent),
          child: InkWell(
            splashColor: Colors.blueGrey,
            onTap: function,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Question #${index + 1}",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                ),
                Text(
                  "${filteredListOfQuestions.elementAt(index).question}",
                ),
                Text(
                  "${filteredListOfQuestions.elementAt(index).correctAnswer}",
                  style: TextStyle(color: Colors.green),
                ),
                Text(
                  "${filteredListOfQuestions.elementAt(index).firstWrongAnswer}",
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  "${filteredListOfQuestions.elementAt(index).secondWrongAnswer}",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
