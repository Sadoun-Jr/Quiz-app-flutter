import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_quiz/login%20layout.dart';
import 'package:students_quiz/quiz%20list%20layout.dart';

class ResultLayout extends StatefulWidget {
  final int score;

  const ResultLayout(this.score, {Key? key}) : super(key: key);

  @override
  State<ResultLayout> createState() => _ResultLayoutState();
}

Color primColor = Colors.blue;
Color secondaryColor = Colors.white;
Color borderColor = Colors.grey;
Color buttonColor = Colors.white;
const String PASS = "Well Done";
const String FAIL = "Try Again";
const String PASSMSG = "Quiz completed successfully.";
const String CORRECTANSWERSMSG = "Correct answers: ";
const String FAILMSG = "Quiz not completed successfully.";
const String MAXSCOREMSG = "Maximum score: ";
const String YOURSCOREMSG = "Your score: ";
const String scorePercent = "75%";
const String maxScore = "92";
const String yourScore = "76";
const String correctAnswers = "24";
const String totalAnswers = "51";

class _ResultLayoutState extends State<ResultLayout> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: primColor,
          body: Center(
              child: Align(
                child: resultBox(),
              ))),
    )
    ;
  }

  Widget resultBox() {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 7,
                blurRadius: 7,
                offset: Offset(5, 10), // changes position of shadow
              ),
            ],
          ),
          margin: const EdgeInsets.fromLTRB(20, 35, 20, 40),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(50.0))),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        height: 150,
                        width: 150,
                        child: Image.asset("images/blue_tick.png")),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              PASS,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                              ),
                            ))),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: const TextSpan(
                          text: scorePercent,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 44,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: " Scored",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 33)),
                          ],
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              PASSMSG,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ))),
                    Container(
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: borderColor, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        margin: const EdgeInsets.fromLTRB(50, 5, 50, 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: const TextSpan(
                              text: MAXSCOREMSG,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: " " + maxScore,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ],
                            ),
                          ),
                        )),
                    Container(
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: borderColor, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        margin: const EdgeInsets.fromLTRB(50, 5, 50, 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: const TextSpan(
                              text: YOURSCOREMSG,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: " " + yourScore,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ],
                            ),
                          ),
                        )),
                    Container(
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: borderColor, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        margin: const EdgeInsets.fromLTRB(50, 5, 50, 10),
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: const TextSpan(
                              text: CORRECTANSWERSMSG,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: " " + correctAnswers,
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                TextSpan(
                                    text: " / " + totalAnswers,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Flexible(
                  child: floatingButton("TO DASHBOARD", Icons.dashboard, navToDashboard),
                  flex: 1,
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                 child: Flexible(
                    child: floatingButton("ANOTHER QUIZ", Icons.next_plan_outlined, navToQuizList),
                    flex: 1,
                  )
              )

            ],
          ),
        )
      ],
    );
  }

  Widget floatingButton(String text,IconData? icon, VoidCallback function) {
    return FloatingActionButton.extended(
      label:  Text(text, style: TextStyle(color: Colors.black),), // <-- Text
      backgroundColor: buttonColor,
      icon: Icon(
        icon,
        color: Colors.black,
      ),
      onPressed: function,
    );
  }

  void navToDashboard() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginLayout())
    );
  }

  void navToQuizList() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizListLayout())
    );
  }

}

