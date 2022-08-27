import 'package:ekstep_assignment/api/implement/todo_repo.dart';
import 'package:ekstep_assignment/model/signinModel.dart';
import 'package:ekstep_assignment/model/todoModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../api/implement/signin_repo.dart';

class HomeController extends GetxController {
  final titleController = TextEditingController().obs;

  final descController = TextEditingController().obs;
  final repo = ToDoRepo();
  final userrepo = signinRepo();
  final todoList = <todoModel>[].obs;
  final UserInfo = userModel(
          uid: FirebaseAuth.instance.currentUser!.uid.toString(),
          email: "",
          profilePic: "",
          name: "")
      .obs;
  @override
  void onInit() {
    super.onInit();
    getallDataBinding();
  }

  getallDataBinding() {
    todoList.bindStream(repo.getallTodoList());
    UserInfo.bindStream(userrepo.getUserStreamById());
  }

  addNewTaskFunction() async {
    if (titleController.value.text != "" && descController.value.text != "") {
      todoModel todomodel = await todoModel(
          id: Uuid().v1().toString(),
          createdDate: DateTime.now(),
          title: titleController.value.text.toString(),
          completed: false,
          description: descController.value.text.toString());

      await repo.addNewTask(todomodel);
      clearController();
      Get.back();
    } else {
      if (titleController.value.text == "") {
        Get.snackbar("Please Add Title", "");
      }
      if (descController.value.text == "") {
        Get.snackbar("Please Add Description", "");
      }
    }
  }

  clearController() {
    titleController.value.clear();
    descController.value.clear();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
