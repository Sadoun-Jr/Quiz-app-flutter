import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:students_quiz/hex%20colors%20class.dart';
import 'package:students_quiz/result%20layout.dart';

import 'answers custom radio.dart';

class QuizQuestionLayout extends StatefulWidget {
  final String quizName; //if you have multiple values add here

  const QuizQuestionLayout(this.quizName, {Key? key}) : super(key: key);

  @override
  State<QuizQuestionLayout> createState() => _QuizQuestionLayoutState();
}

int _value = 1;
var questionText =
    "What is the most useful piece of information you learned today?";
var answerA = "I learned about the pyramids of Giza today";
var answerB = "Today wasn't so exciting";
var answerC = "Watched a few Youtube videos";
var answerD = "All of the above";
Color primColor = HexColor("#001f3e");
Color secondaryColor = Colors.white;
Color borderColor = Colors.white;
Color buttonColor = Colors.white;

var questionNumber = 23;
var totalQuestions = 50;

class _QuizQuestionLayoutState extends State<QuizQuestionLayout>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..addListener(() {
        setState(() {});
      });

    controller.repeat(reverse: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
          textTheme: Typography(platform: TargetPlatform.iOS).white,
        ),
        home: Scaffold(
            backgroundColor: primColor,
            body: Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  timer(),
                  const SizedBox(height: 10),
                  questionNumberLayout(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    questionText,
                    style: const TextStyle(
                        height: 1.5, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    height: 75,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30.0)),
                        border: Border.all(color: borderColor, width: 2)),
                    child: MyRadioListTile<int>(
                      value: 1,
                      groupValue: _value,
                      leading: 'a',
                      title: Text(
                        answerA,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,

                            fontSize: 17, fontWeight: FontWeight.w500),
                        maxLines: 3,
                      ),
                      onChanged: (value) => setState(() => _value = value!),
                    ),
                  ),
                  Container(
                    height: 75,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(30.0)),
                        border: Border.all(
                          color: borderColor,
                          width: 2,
                        )),
                    child: MyRadioListTile<int>(
                      value: 2,
                      groupValue: _value,
                      leading: 'b',
                      title: Text(
                        answerB,
                        style: const TextStyle(
                          color: Colors.white,
                            fontSize: 17, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      onChanged: (value) => setState(() => _value = value!),
                    ),
                  ),
                  Container(
                    height: 75,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(30.0)),
                        border: Border.all(color: borderColor, width: 2)),
                    child: MyRadioListTile<int>(
                      value: 3,
                      groupValue: _value,
                      leading: 'c',
                      title: Text(
                        answerC,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      onChanged: (value) => setState(() => _value = value!),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  bottomNavBox(),
                ],
              ),
            )));
  }

  Widget bottomNavBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: prevQuestionButton(),
        ),
        Align(
          alignment: Alignment.center,
          child: finishQuiz(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: nextQuestionButton(),
        )
      ],
    );
  }

  Widget finishQuiz() {
    return FloatingActionButton.extended(
      label: const Text("SUBMIT", style: TextStyle(color: Colors.black),), // <-- Text
      backgroundColor: buttonColor,
      icon: Icon(Icons.save, color: Colors.black,),
      onPressed: navigateToResultScreen,
    );
  }

  Widget prevQuestionButton() {
    return FloatingActionButton(
      backgroundColor: buttonColor,
      child: const Icon(
        // <-- Icon
        Icons.arrow_back_ios_outlined,color: Colors.black,
        size: 24.0,
      ),
      onPressed: () {},
    );
  }

  Widget nextQuestionButton() {
    return FloatingActionButton(

      backgroundColor: buttonColor,
      child: const Icon(
        // <-- Icon
        Icons.arrow_forward_ios_outlined,color: Colors.black,
        size: 24.0,
      ),
      onPressed: () {},
    );
  }

  Widget gradientButton(String text, Function() fun) {
    return Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: GradientButton(
          child: Text(text,
              style: const TextStyle(
                color: Colors.white,
              )),
          increaseWidthBy: double.infinity,
          callback: fun,
          gradient: Gradients.taitanum,
          shadowColor: Gradients.deepSpace.colors.last.withOpacity(0.25),
        ));
  }

  Widget timer() {
    return Stack(children: <Widget>[
      Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(const Radius.circular(20)),
            border: Border.all(color: borderColor, width: 2)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              minHeight: 35,
              color: Colors.white,
              backgroundColor: Colors.transparent,
              value: controller.value,
              semanticsLabel: 'Linear progress indicator',
            )),
      ),
      Align(
        alignment: Alignment.center,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
          padding: const EdgeInsets.fromLTRB(15, 6, 15, 0),
          child: const Text("21", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          padding: const EdgeInsets.fromLTRB(15, 6, 15, 0),
          child: const Icon(Icons.access_time, color: Colors.white,),
        ),
      ),
    ]);
  }

  Widget questionNumberLayout() {
    String quizName = widget.quizName;
    return Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.white)),
        ),
        child: Row(
          children: <Widget>[
            Text(
              "Question $questionNumber",
              style: const TextStyle(fontSize: 20,color : Colors.white54, fontWeight: FontWeight.bold),
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onPressedNull() {}

  void navigateToResultScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultLayout(543)
        )
    );
  }
}
