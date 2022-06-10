import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:students_quiz/admin%20dashboard.dart';
import 'package:students_quiz/create%20new%20quiz%20layout.dart';
import 'package:students_quiz/create%20new%20quiz%20name%20and%20warning.dart';
import 'package:students_quiz/main.dart';
import 'package:students_quiz/quiz%20list%20layout.dart';
import 'package:students_quiz/register%20layout.dart';
import 'package:students_quiz/reset%20password%20layout.dart';
import 'package:students_quiz/student%20dashboard.dart';
import 'edit quiz list.dart';
import 'hex colors class.dart';
import 'package:students_quiz/Utils.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({Key? key}) : super(key: key);

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
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
Color primColor = HexColor("#001f3e");
Color secondaryColor = Colors.white;
bool? isAdminBool = null;
const String CREATE_NEW_QUIZ = "Create a new quiz";
const String EDIT_QUIZ = "Edit existing quiz";
const String DELETE_QUIZ = "Delete existing quiz";
const String LIST_STUDENTS = "Quiz Stats";
String role = "user";
Widget _body = Container(child: Text("DDDDDDDDD")); // Default Body
late SharedPreferences prefs;

class _LoginLayoutState extends State<LoginLayout> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return whichDashBoardStream();
            } else {
              return loginScreen();
            }
          },
        ));
  }

  Widget whichDashBoardStream() {

    var collection = FirebaseFirestore.instance.collection('users');
    User? user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: collection.doc('${user?.uid}').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          var output = snapshot.data!.data();
          var value = output!['role'];
          if(value == "admin"){
            return adminDashBoardLayout();
          } else if (value == "user"){
            return dashboardScreen();
          }

        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void checkRole() async {
    var collection = FirebaseFirestore.instance.collection("users");
    User? user = FirebaseAuth.instance.currentUser;
    var docSnapshot = await collection.doc(user?.uid).get();
    prefs = await SharedPreferences.getInstance();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      role = docSnapshot["role"];

      if (data["role"] == "admin") {
        isAdminBool = true;
        await prefs.setBool('admin', true);
      } else if (data["role"] == "user") {
        isAdminBool = false;
      } else {
        _body = loginScreen();
        isAdminBool = null;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkRole();
  }


  void navToCreateNewQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NameNewQuizAndWarning()),
    );
  }

  Widget dashboardScreen() {
    return Scaffold(backgroundColor: primColor, body: dashboardMain());
  }

  Widget loginScreen() {
    return Container(
      color: primColor,
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 125,
            width: double.infinity,
            color: primColor,
            child: const Center(
              child: Text(
                schoolName,
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
          loginBox(),
        ],
      ),
    );
  }

  Widget loginBox() {
    return Container(
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
              spreadRadius: 8,
              blurRadius: 9,
            ),
          ],
        ),
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 30),
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: primColor, width: 1))),
                child: Text(
                  LOGIN_SCREEN_HEADER,
                  style: TextStyle(
                      fontSize: 24,
                      color: primColor,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: EMAIL,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  labelText: passWord,
                )),
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
                LOGIN,
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: signIn,
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
              backgroundColor: Colors.white,
              label: Text(
                FORGOT_PASSWORD,
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              onPressed: navigateToResetPassLayout,
            ),
          ),
          Row(
            children: <Widget>[
              const Text(
                noAccountRegisterPlease,
                style: TextStyle(fontSize: 18),
              ),
              TextButton(
                onPressed: registerNewAcc,
                child: const Text(
                  register,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ]));
  }

  String getUsernameFromEmail() {
    return "Username";
  }

  void navigateToResetPassLayout() {
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => const ResetPassWord()),
    );
  }

  void registerNewAcc() {
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => const RegisterNewUserLayout()),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: slider()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );

      var collection = FirebaseFirestore.instance.collection("users");
      User? user = FirebaseAuth.instance.currentUser;
      var docSnapshot = await collection.doc(user?.uid).get();
      debugPrint("Role is ""${docSnapshot["role"]} for user ${docSnapshot["email"]}");

      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          msg: "Logged in Successfully as ${FirebaseAuth.instance.currentUser?.email}",
          toastLength: Toast.LENGTH_LONG);

    } catch (e) {

      debugPrint(e.toString());
      Fluttertoast.showToast(
          backgroundColor: Colors.red,
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG);

    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
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
                        "Welcome back, WIDGET",
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

  void navToTestAdminDashBoard() {
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => const AdminDashBoardLayout()),
    );
  }

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
          color: primColor,
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

  Widget rankingBox() {
    return Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        color: Colors.transparent,
        child: Center(
          child: Text(STUDENT_RANK + ":   $ranking"),
        ));
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
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void navigateToQuizListScreen() {
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => const QuizListLayout()),
    );
  }

  void navigateToCreateNewQuiz() {
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => const NameNewQuizAndWarning()),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget adminDashBoardLayout() {

    return Scaffold(
      body: Container(
        color: primColor,
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            welcomeBackRectangleAdmin(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                bigFAB(CREATE_NEW_QUIZ,
                    navToCreateNewQuiz,
                    1),
                Spacer(),
                bigFAB(EDIT_QUIZ, navToEditOrDeleteQuizAdmin, 2),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                bigFAB(DELETE_QUIZ, onPressed, 3),
                Spacer(),
                bigFAB(LIST_STUDENTS, onPressed, 4),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton.extended(
              heroTag: 6,
              onPressed: showConfLogOutDialog,
              backgroundColor: Colors.white,
              label: Text(
                LOGOUT,
                style: TextStyle(color: Colors.blue),
              ),
              icon: Icon(
                Icons.logout,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bigFAB(String text, VoidCallback function, int heroTag) {
    return SizedBox(
        height: 170,
        width: 170,
        child: FloatingActionButton(
            heroTag: heroTag,
            backgroundColor: secondaryColor,
            child: Text(
              text,
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: function));
  }

  void onPressed() {}

  Widget welcomeBackRectangleAdmin() {
    return Container(
        padding: const EdgeInsets.all(7),
        height: 150.0,
        width: double.infinity,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1),
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.45),
                spreadRadius: 0,
                blurRadius: 8,
                offset: Offset(0, 8), // Shadow position
              ),
            ],
          ),
          child: Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    child: Text(
                      "Welcome back, ",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    NAME,
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 36,
                    ),
                  ),
                  Text(
                    "ADMIN WIDGET",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 30,
                    ),
                  ),
                ],
              )),
        ));
  }

  void navToEditOrDeleteQuizAdmin() {
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => const EditQuizListLayout()),
    );
  }
}
