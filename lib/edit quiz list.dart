import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_quiz/Utils.dart';
import 'package:students_quiz/create%20new%20quiz%20layout.dart';
import 'package:students_quiz/edit%20single%20quiz%20layout%20admin.dart';
import 'package:students_quiz/quizzes%20static.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'hex colors class.dart';

class EditQuizListLayout extends StatefulWidget {
  const EditQuizListLayout({Key? key}) : super(key: key);

  @override
  State<EditQuizListLayout> createState() => _EditQuizListLayoutState();
}

var number = 0;
Color primColor = Colors.blueAccent;
bool isAdmin = true;
const String CHOOSE_QUIZ_TO_EDIT = "Edit a Quiz";
const String ERROR_LOADING_DATA = "Error loading data, check connection";
const String LOADING_DATA = "Loading...";
const String WHAT_TO_DO = "What would you like to do?";
List<SingleQuizItem> entireListOfQuizzesIncludingQuestions = [];
List entireDb = [];
List filteredQuizNames = [];
int key = 0;
String QUIZ_NAME_KEY = "quiz name";
String QUESTION_KEY = "question";
String QUESTION_NUMBER_KEY = "question number";
String CORRECT_ANSWER_KEY = "correct answer";
String FIRST_WRONG_ANSWER_KEY = "first wrong answer";
String SECOND_WRONG_ANSWER_KEY = "second wrong answer";


class _EditQuizListLayoutState extends State<EditQuizListLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primColor,
      body: ListView(
        children: <Widget>[
          selectQuizBox(),
          quizListBox(),
        ],
      ),
    );
  }

  @override
  void initState() {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: "Refreshing Quizzes...");

    // Future.delayed(Duration(milliseconds: 2000), () {
    //   setState(() {});
    // });
    super.initState();
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
                    CHOOSE_QUIZ_TO_EDIT,
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
              offset: Offset(0, 8), // Shadow position
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
                entireListOfQuizzesIncludingQuestions.clear();
                getSingleQuizLoop(element.id.toString());
              });
            });
            return Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: filteredQuizNames.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        inkWellButton(index,
                        () => navigateToEditSingleQuiz(
                          filteredQuizNames[index]
                        )),
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

  void showToast(int index) async{
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: "This is index#${index}");
  }

  void navigateToEditSingleQuiz(String quizName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditSingleQuizListOfQuestions(quizName)));
  }

  Widget inkWellButton(int index, VoidCallback function) {
    return Container(
        child: SizedBox.fromSize(
          size: Size(double.infinity, 100),
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
                      "Quiz #${index+1}",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                    ),
                    Text(
                      "${filteredQuizNames.elementAt(index)}",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void onPressedSetState(BuildContext context) {
    setState(() {});
  }

  void showOptionsDialogue() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => Material(
          type:MaterialType.transparency,
          child: Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
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
                      spreadRadius: 4,
                      blurRadius: 9,
                    ),
                  ],
                ),
                height: 175,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      child: Text(WHAT_TO_DO, style: TextStyle(fontSize: 20),),
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
                    TextButton(onPressed: () => {}, child: Text("EDIT")),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("DELETE")),
                  ],
                ),
              )
          )
            ));
  }


  //slidable list item library
  Widget slidableListItem() {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: UniqueKey(),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () => setState(() {})),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: onPressedSetState,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: onPressedSetState,
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
                motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: onPressedSetState,
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: onPressedSetState,
            backgroundColor: Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: const ListTile(title: Text('Slide me')),
    );
  }

  void getQuizzes() {
    var collection = FirebaseFirestore.instance.collection('quizzes');
    final result = FirebaseFirestore.instance.collection('quizzes');
    result.get().then((snapshot) {
      snapshot.docs.forEach((element) {
        getSingleQuizLoop(element.id.toString());
      });
    });
    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: collection.doc('quizzes').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');
        if (snapshot.hasData) {
          var output = snapshot.data!.data();
          entireListOfQuizzesIncludingQuestions.clear();
          final result = FirebaseFirestore.instance.collection('quizzes');
          result.get().then((snapshot) {
            snapshot.docs.forEach((element) {
              getSingleQuizLoop(element.id.toString());
              print(element.id);
            });
          });
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void getSingleQuizLoop(String element) {
    int i = 0;
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

        entireDb.add(element.data()[QUIZ_NAME_KEY]);
        entireListOfQuizzesIncludingQuestions.add(quizItem);

      }
      //filter multiple quiz instances
      filteredQuizNames = entireDb.toSet().toList();
    }));
  }

  void proceedToSelectedQuiz(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            // builder: (context) => SpecificQuizInfo("Quiz #${index+1}")
            builder: (context) => CreateNewQuizAdmin("Quiz #${index + 1}")));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
