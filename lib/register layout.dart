import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Utils.dart';
import 'main.dart';

class RegisterNewUserLayout extends StatefulWidget {
  const RegisterNewUserLayout({Key? key}) : super(key: key);

  @override
  State<RegisterNewUserLayout> createState() => _RegisterNewUserLayoutState();
}

const String schoolName = "TEXAS SCHOOL";
const String REGISTER_NEW_ACC = "Create a new account";
const String register = "Register";
const String userName = "User Name - not implemented yet";
const String passWord = "Password";
const String EMAIL = "Email";
const String forgotPass = "Forgot Password";
const String REGISTER_BTN = "REGISTER";
const String noAccountRegisterPlease = "Don't have an account?";
const String namePrefs = "";
const String ALREADY_HAVE_ACCOUNT = "Already have an account?";
const String USER_REGISTERED = "User registered successfully";
const String ADMIN_REGISTERED = "Admin registered successfully";
const String LOGIN = "Login";

bool isRegisteringAsAdmin = false;

TextEditingController nameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController emailController = TextEditingController();

class _RegisterNewUserLayoutState extends State<RegisterNewUserLayout> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.blue,
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 100,
            width: double.infinity,
            color: Colors.blue,
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
    ));
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
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(5, 5)),
          ],
        ),
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 30),
            child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.blue, width: 1))),
                child: Text(
                  REGISTER_NEW_ACC,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Container(
              child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? "Enter a valid Email"
                              : null,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: EMAIL,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? "Password can't be less than 6 characters"
                          : null,
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: passWord,
                      )),
                ),
              ],
            ),
          )),
          SizedBox(
            height: 10,
          ),
          LabeledCheckbox(
            label: 'Register as Admin',
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: isRegisteringAsAdmin,
            onChanged: (bool newValue) {
              setState(() {
                isRegisteringAsAdmin = newValue;
              });
            },
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 50,
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 15),
            child: FloatingActionButton.extended(
              label: Text(
                REGISTER_BTN,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: signUp,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                text: ALREADY_HAVE_ACCOUNT + " ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => backToMainMenu(),
                      text: LOGIN,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ]));
  }

  Widget floatingButton(String text, IconData? icon, VoidCallback function) {
    return FloatingActionButton.extended(
      label: Text(
        text,
      ), // <-- Text
      backgroundColor: Colors.blueAccent,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: function,
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      Fluttertoast.showToast(
          backgroundColor: Colors.red,
          msg: "Fill the form correctly",
          toastLength: Toast.LENGTH_LONG);
      return;
    }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: slider()),
      );

      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
            .then((value) async {
          if(isRegisteringAsAdmin) {
            User? user = FirebaseAuth.instance.currentUser;
            await FirebaseFirestore.instance
                .collection("users")
                .doc(user?.uid)
                .set({
              "uid": user?.uid,
              "email": emailController.text.trim(),
              "role": "admin"
            });
            Fluttertoast.showToast(
                backgroundColor: Colors.green,
                msg: ADMIN_REGISTERED,
                toastLength: Toast.LENGTH_LONG);
          } else {
            User? user = FirebaseAuth.instance.currentUser;
            await FirebaseFirestore.instance
                .collection("users")
                .doc(user?.uid)
                .set({
              "uid": user?.uid,
              "email": emailController.text.trim(),
              "role": "user"
            });
            Fluttertoast.showToast(
                backgroundColor: Colors.green,
                msg: USER_REGISTERED,
                toastLength: Toast.LENGTH_LONG);
          }
        });
      } catch (e) {
        debugPrint("Sign up error: " + e.toString());
        Fluttertoast.showToast(
            backgroundColor: Colors.red,
            msg: e.toString(),
            toastLength: Toast.LENGTH_LONG);
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }



  void backToMainMenu() {
    Navigator.pop(context);
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
