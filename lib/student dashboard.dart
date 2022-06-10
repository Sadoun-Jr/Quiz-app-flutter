import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_quiz/login%20layout.dart';
import 'package:students_quiz/quiz%20list%20layout.dart';

import 'Utils.dart';
import 'hex colors class.dart';
import 'main.dart';

class StudentDashBoardScreen extends StatefulWidget {
  const StudentDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<StudentDashBoardScreen> createState() => _StudentDashBoardScreenState();
}

const String schoolName = "TEXAS SCHOOL";
const String LOGIN_SCREEN_HEADER = "Sign in portal";
const String register = "Register";
const String userName = "User Name";
const String EMAIL = "Email";
const String passWord = "Password";
const String FORGOT_PASSWORD = "Forgot Password";
const String LOGIN = "LOGIN";
const String noAccountRegisterPlease = "Don't have an account?";
var name = "";
var finishedGrabbingName = false;
const String LOGOUT = "LOGOUT";
const String QUIZ_LIST = "QUIZ LIST";
const String STUDENT_RANK = "Student Rank";
const String QUIZZES_COMPLETED = "Quizzes";
const String TOTAL_SCORE = "Total Score";
const String CORRECT_ANSWERS = "Correct Ans.";
const String WRONG_ANSWERS = "Wrong Ans.";
var quizzesCompleted = 22;
var totalScore = 521;
var correctAnswers = 442;
var wrongAnswers = 21;
var ranking = 23;
var borderRadius = 50.0;
Color primColor = Colors.blue;
Color secondaryColor = Colors.white;
bool? isAdminBool = false;
const String CREATE_NEW_QUIZ = "Create a new quiz";
const String EDIT_QUIZ = "Edit existing quiz";
const String DELETE_QUIZ = "Delete existing quiz";
const String LIST_STUDENTS = "Quiz Stats";
String role = "user";

class _StudentDashBoardScreenState extends State<StudentDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: primColor, body: dashboardMain());
  }

  Widget dashboardMain() {
    return ListView(
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Center(
              child: welcomeBackRectangleWithText(),
            )),
        Container(
          child: dashBoardBody(),
        ),
        //TODO: check that this bottom bar is actually stuck at the bottom of screen
        //DO NOT USE SPACER() HERE BECAUSE IT CAN CAUSE RENDER ISSUES
        Align(
          alignment: Alignment.bottomCenter,
          child: bottomButtonsBar(),
        )
      ],
    );
  }

  Widget welcomeBackRectangleWithText() {
    return Container(
        padding: const EdgeInsets.all(7),
        height: 100.0,
        width: double.infinity,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          child: Center(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(7),
                      child: const Text(
                        "Welcome back, ROUTE",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      )),
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 36,
                    ),
                  ),
                ],
              )),
        ));
  }

  Widget dashBoardBody() {
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        width: double.infinity,
        color: Colors.transparent,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadius))),
            child: Center(
              child: rankingBox(),
            ),
          ),
          Container(
            child: circleInBoxLayoutStats(
                quizzesCompleted, QUIZZES_COMPLETED, totalScore, TOTAL_SCORE),
          ),
          Container(
            child: circleInBoxLayoutStats(
                correctAnswers, CORRECT_ANSWERS, wrongAnswers, WRONG_ANSWERS),
          ),
        ]));
  }

  Widget bottomButtonsBar() {
    return Container(
        color: Colors.white,
        child: Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 5),
            child: Row(
              children: [
                bottomhalfButton("Logout", Icons.logout, showConfLogOutDialog),
                Spacer(),
                bottomhalfButton(
                    "Quiz", Icons.question_mark, navigateToQuizListScreen),
                Spacer(),
                bottomhalfButton("Share", Icons.share, null)
              ],
            )));
  }

  void navigateToQuizListScreen() {
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => const QuizListLayout()),
    );
  }

  void showConfLogOutDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 9,
                  ),
                ],
              ),
              height: 175,
              width: 250,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Confirm Logout?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                      height: 2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black12,
                              width: 1,
                            ),
                          ))),
                  TextButton(onPressed: signOut, child: Text("YES")),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("NO")),
                ],
              ),
            )));
  }

  void signOut() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: slider()),
    );

    try {
      await FirebaseAuth.instance.signOut();
      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          msg: "Logout successful",
          toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
          backgroundColor: Colors.red,
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG);
    }

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginLayout()));  }


  Widget bottomhalfButton(String text, IconData icon, VoidCallback? function) {
    return Container(
        child: SizedBox.fromSize(
          size: Size(60, 60),
          child: ClipOval(
            child: Material(
              color: (HexColor("#ffffff")),
              child: InkWell(
                splashColor: Colors.blueGrey,
                onTap: function,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.blue,
                    ), // <-- Icon
                    Text(
                      text,
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ), // <-- Text
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget rankingBox() {
    return Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        color: Colors.transparent,
        child: Center(
          child: Text(STUDENT_RANK + ":   $ranking"),
        ));
  }

  Widget circleInBoxLayoutStats(
      int firstNumber, String firstStat, int secondNumber, String secondStat) {
    return Container(
      height: 220.0,
      color: secondaryColor,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Flexible(
              child: backGroundSquareForStats(firstNumber, firstStat),
              flex: 1,
            ),
            Flexible(
              child: backGroundSquareForStats(secondNumber, secondStat),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget backGroundSquareForStats(int number, String stat) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: const EdgeInsets.all(15),
      height: 200.0,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundColor: secondaryColor,
                radius: 50,
                child: Center(
                  child: Text(
                    "$number",
                    style: TextStyle(
                        fontSize: 20,
                        color: primColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    stat,
                    style: const TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }


}
