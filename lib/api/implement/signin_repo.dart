import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekstep_assignment/api/abstract/signin_abs.dart';
import 'package:ekstep_assignment/app/modules/home/views/home_view.dart';
import 'package:ekstep_assignment/app/routes/app_pages.dart';
import 'package:ekstep_assignment/model/signinModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:get_cli/common/utils/json_serialize/json_ast/utils/grapheme_splitter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../constant/firebase.dart';

class signinRepo extends SignInAbs {
  //Google sign in method implement
  googleSignIn() async {
    // final googleSignIn = GoogleSignIn();

    // final googleuser = await googleSignIn.signIn();
    // if (googleuser == null) {
    //   return;
    // }
    // final googleauth = await googleuser.authentication;
    // final cred = GoogleAuthProvider.credential(
    //     accessToken: googleauth.accessToken, idToken: googleauth.idToken);
    // await FirebaseAuth.instance.signInWithCredential(cred).then((value) {
    //   final user=cred.
    //   addDataUser();
    // });
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignInAccount? googleUSer = await GoogleSignIn().signIn();
    if (googleUSer != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUSer.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        final user = await userCredential.additionalUserInfo!.profile;
        final isyes = await userCredential.additionalUserInfo!.isNewUser;
        log(isyes.toString());

        log(user!["name"].toString());
        if (isyes == true) {
          addDataUser(user);
        } else {
          Get.offAll(() => HomeView());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          log("chane");
        } else if (e.code == "invalid-credential") {
          log("no");
        }
      } catch (e) {
        log(e.toString());
      }
    }
    return user;
  }

  addDataUser(Map map) async {
    try {
      if (FirebaseAuth.instance.currentUser!.uid != null) {
        await FirebaseFirestore.instance
            .collection(Collections.usersCollection)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "uid": FirebaseAuth.instance.currentUser!.uid.toString(),
          "name": map["name"],
          "email": map["email"],
          "profilePic": map["picture"],
        }).then((value) {
          Get.offAll(() => HomeView());
        });

        log('User created Successfully: ${FirebaseAuth.instance.currentUser!.uid}');
      }
    } catch (e) {
      Get.snackbar("Failed", e.toString());
    }
    Get.offAll(() => HomeView());
  }

  Stream<userModel> getUserStreamById() {
    return FirebaseFirestore.instance
        .collection(Collections.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((doc) => userModel.fromMap(doc.data() as Map<String, dynamic>,
            FirebaseAuth.instance.currentUser!.uid));
  }

  twitterSignin() async {
    final twitterLogin = new TwitterLogin(
        apiKey: 'XXFb8Y57dpoKJyGnYy8YhEFMV',
        apiSecretKey: 'plf5DNMty7tMd0FFRV2LugBsmp1CmJAw8KVlbiF3Tg3qOeuxIC',
        redirectURI: 'flutter-twitter-auth://');

    await twitterLogin.login().then((value) async {
      try {
        final twitterAuthCredential = TwitterAuthProvider.credential(
            accessToken: value.authToken.toString(),
            secret: value.authTokenSecret.toString());
        try {
          final signin = await FirebaseAuth.instance
              .signInWithCredential(twitterAuthCredential);
          final result = AuthResult();
          log(result.toString());
          log(signin.additionalUserInfo.toString());
        } catch (e) {
          log("hiiii______________" + e.toString());
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
