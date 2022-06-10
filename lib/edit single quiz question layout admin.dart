import 'package:flutter/material.dart';

import 'create new quiz layout.dart';

class EditQuestionLayout extends StatefulWidget {
  final String question;
  final String correctAnswer;
  final String firstWrongAnswer;
  final String secondWrongAnswer;
  const EditQuestionLayout(this.question,this.correctAnswer,
      this.firstWrongAnswer,this.secondWrongAnswer,{Key? key}) : super(key: key);

  @override
  State<EditQuestionLayout> createState() => _EditQuestionLayoutState();
}

class _EditQuestionLayoutState extends State<EditQuestionLayout> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();


    TextEditingController questionController =
      TextEditingController(text: widget.question);
      TextEditingController correctAnswerController =
      TextEditingController(text: widget.correctAnswer);
      TextEditingController firstWrongAnswerController =
      TextEditingController(text: widget.firstWrongAnswer);
      TextEditingController secondWrongAnswerController =
      TextEditingController(text: widget.secondWrongAnswer);

      return Material(
              type:MaterialType.transparency,
              child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  height: 300,
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
                  ])
              )
          );
    }
  }
