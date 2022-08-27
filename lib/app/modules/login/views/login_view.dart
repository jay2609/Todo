import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekstep_assignment/utils/Icon_Image_Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
    FirebaseFirestore.instance.collection("s").add({"D": "D"});
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Welcome to To-Do App'),
        centerTitle: true,
      ),
      body: Center(
          child: ListView(
        children: [
          SizedBox(
            height: 100,
          ),
          const Text("Welcome to",
              style: TextStyle(fontSize: 20), textAlign: TextAlign.center),

          const Text("My ToDo App",
              style: TextStyle(fontSize: 40), textAlign: TextAlign.center),
          SizedBox(
            height: 50,
          ),
          const Text("Sign in with",
              style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          //Google Sign in Button
          IconImageButton(
            iconText: "Google",
            onTap: () {
              controller.repo.googleSignIn();
            },
          ),

          //Twitter Sign in Button
          IconImageButton(
            iconText: "Twitter",
            onTap: () {
              controller.repo.twitterSignin();
            },
          )
        ],
      )),
    );
  }
}
