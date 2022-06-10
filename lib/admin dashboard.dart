import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_quiz/login%20layout.dart';

import 'Utils.dart';
import 'edit quiz list.dart';

class AdminDashBoardLayout extends StatefulWidget {
  const AdminDashBoardLayout({Key? key}) : super(key: key);

  @override
  State<AdminDashBoardLayout> createState() => _AdminDashBoardLayoutState();
}

Color primColor = Colors.blue;
Color secondaryColor = Colors.white;
var borderRadius = 50.0;
String NAME = "PH Name";
const String CREATE_NEW_QUIZ = "Create a new quiz";
const String EDIT_QUIZ = "Edit existing quiz";
const String DELETE_QUIZ = "Delete existing quiz";
const String LIST_STUDENTS = "Quiz Stats";
const String LOGOUT = "LOGOUT";

class _AdminDashBoardLayoutState extends State<AdminDashBoardLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primColor,
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            welcomeBackRectangleWithText(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                bigFAB(CREATE_NEW_QUIZ, onPressed,1),
                Spacer(),
                bigFAB(EDIT_QUIZ, onPressed, 2),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                bigFAB(DELETE_QUIZ, onPressed, 3),
                Spacer(),
                bigFAB(LIST_STUDENTS, onPressed,4 ),
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
        context, MaterialPageRoute(builder: (context) => LoginLayout()));
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

  Widget welcomeBackRectangleWithText() {
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
                color: Colors.grey.withOpacity(0.75),
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
                  "Welcome back, ADMIN ROUTE",
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
                "ADMIN ROUTE",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                ),
              ),
            ],
          )),
        ));
  }

  void editOrDeleteQuiz() {
    Navigator.push(
      this.context,
      MaterialPageRoute(builder: (context) => const EditQuizListLayout()),
    );
  }
}
