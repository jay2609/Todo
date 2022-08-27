import 'dart:async';
import 'dart:developer';

import 'package:ekstep_assignment/app/modules/home/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../login/views/login_view.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    late StreamSubscription<User?> user;
    Timer(
        Duration(seconds: 5),
        () => user = FirebaseAuth.instance.authStateChanges().listen((user) {
              if (user == null) {
                log("message");
                Get.offAll(() => LoginView());
              } else {
                Get.offAll(() => HomeView());
                log("Gooo");
              }
            }));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
