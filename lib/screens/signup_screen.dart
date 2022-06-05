import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("ffffff"),
                hexStringToColor("30d5c8"),
                hexStringToColor("000000")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter UserName", Icons.person_outline, false,
                        _userNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email Id", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Height", Icons.height, false,
                        _heightController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Weight", Icons.line_weight, false,
                        _weightController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Gender", Icons.transgender, false,
                        _genderController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Sign Up", () {
                      // FirebaseAuth.instance
                      //     .createUserWithEmailAndPassword(
                      //     email: _emailTextController.text,
                      //     password: _passwordTextController.text)
                      //     .then((value) {
                      //   print("Created New Account");
                      //   FirebaseFirestore.instance.collection("UserData").doc(value.user?.uid).set({
                      //     "email": value.user?.email
                      //   });
                      //
                      // }).onError((error, stackTrace) {
                      //   print("Error ${error.toString()}");
                      // });
                         registerUser();
                         Navigator.push(context,
                             MaterialPageRoute(builder: (context) => SignInScreen()));
                    })
                  ],
                ),
              ))),
    );
  }
  Future registerUser() async {
    FirebaseAuth auth  = FirebaseAuth.instance;
    User? user = await FirebaseAuth.instance.currentUser;

    try {
      await auth.createUserWithEmailAndPassword(email: _emailTextController.text, password: _passwordTextController.text).then((signedInUser) => {
        FirebaseFirestore.instance.collection("Users").doc(signedInUser.user?.uid).set({
          "name" : _userNameTextController.text,
          "email" : _emailTextController.text,
          "password" : _passwordTextController.text,
          "height": _heightController.text,
          "weight": _weightController.text,
          "gender": _genderController.text,
          "url": "https://firebasestorage.googleapis.com/v0/b/signin-example-238d7.appspot.com/o/avatar.jpg?alt=media&token=f7f442d7-a8c4-4caa-a0c8-eac53c1d669c",
            }).then((signedInUser) => {
              print("succes"),
              Fluttertoast.showToast(msg : "Success")
        })
        });
    }  catch (e) {
      print(e);
    }
    
  }

}

