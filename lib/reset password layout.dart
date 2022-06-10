import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Utils.dart';
import 'main.dart';

class ResetPassWord extends StatefulWidget {
  const ResetPassWord({Key? key}) : super(key: key);

  @override
  State<ResetPassWord> createState() => _ResetPassWordState();
}

const String schoolName = "TEXAS SCHOOL";
const String TYPE_EMAIL = "Type your email";
const String RESET_PASSWORD = "Reset Password";
TextEditingController emailController = TextEditingController();
const String EMAIL = "Email";

class _ResetPassWordState extends State<ResetPassWord> {
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
              resetPassBox(),

            ],
          ),
        ));
  }

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: slider()),
    );

    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim());

      Fluttertoast.showToast(msg: "Sent password reset mail to: " + emailController.text.trim(),
          backgroundColor: Colors.green,
          toastLength: Toast.LENGTH_LONG
      );
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(msg: e.toString(),
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_LONG
      );
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);

  }

  Widget resetPassBox() {
    return Center(
      child: Container(
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
                          bottom: BorderSide(color: Colors.blue, width: 1))),
                  child: Text(
                    TYPE_EMAIL,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
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
                  RESET_PASSWORD,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onPressed: resetPassword,
              ),
            ),
            SizedBox(height: 20,)
          ],
          )
      ),
        );


  }



}



