import 'dart:developer';

import 'package:ekstep_assignment/app/modules/login/views/login_view.dart';
import 'package:ekstep_assignment/utils/Icon_Image_Button.dart';
import 'package:ekstep_assignment/utils/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: (() {
            Get.bottomSheet(
              backgroundColor: Colors.white,
              ListView(
                children: [
                  TextFieldCom(
                    maxLine: 1,
                    controller: controller.titleController.value,
                    title: "Title",
                  ),
                  TextFieldCom(
                    maxLine: 8,
                    controller: controller.descController.value,
                    title: "Description",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            controller.clearController();
                            Get.back();
                          },
                          child: Text("Cancel"),
                          color: Colors.redAccent,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            controller.addNewTaskFunction();
                          },
                          child: Text("Add"),
                          color: Colors.greenAccent,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
        ),
        drawer: Obx(
          () => Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName:
                        Text(controller.UserInfo.value.name.toUpperCase()),
                    accountEmail: Text(controller.UserInfo.value.email),
                    currentAccountPicture: CircleAvatar(
                        child: Image.network(
                            controller.UserInfo.value.profilePic)),
                  ),
                  ListTile(
                    onTap: () {
                      Get.offAll(() => HomeView());
                    },
                    title: Text("My Task's"),
                    leading: Icon(Icons.pending_actions_sharp),
                  ),
                  ListTile(
                    onTap: () {
                      GoogleSignIn().signOut();
                      FirebaseAuth.instance.signOut();

                      Get.offAll(() => LoginView());
                    },
                    title: Text("Log out"),
                    leading: Icon(Icons.logout),
                  )
                ],
              )),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          title: Text('To Do List'),
          centerTitle: true,
        ),
        body: Obx(
          (() => controller.todoList.isEmpty
              ? const Center(
                  child: Text(
                  "No Task Available",
                  style: TextStyle(fontSize: 20),
                ))
              : ListView.builder(
                  itemCount: controller.todoList.length,
                  itemBuilder: (context, index) {
                    log(controller.todoList.length.toString());
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        //onTap Dialg with edit and delete, Complete
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                TextEditingController title =
                                    TextEditingController(
                                        text: controller.todoList[index].title);
                                TextEditingController desc =
                                    TextEditingController(
                                        text: controller
                                            .todoList[index].description);
                                return AlertDialog(
                                    actions: [
                                      IconButton(
                                        tooltip: "Delete",
                                        color: Colors.redAccent,
                                        onPressed: () async {
                                          await controller.repo.DeleteTask(
                                              controller.todoList[index].id);
                                          print(controller.todoList[index].id);
                                          Get.back();
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                      IconButton(
                                        tooltip: "Edit Task",
                                        onPressed: () async {
                                          await controller.repo.EditTask(
                                              title.text,
                                              desc.text,
                                              controller.todoList[index].id);
                                          print(controller.todoList[index].id);
                                          Get.back();
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      IconButton(
                                          tooltip: "Mark to Complete Task",
                                          color: Colors.greenAccent,
                                          onPressed: () async {
                                            await controller.repo
                                                .updateOneField(
                                                    "completed",
                                                    true,
                                                    controller
                                                        .todoList[index].id);
                                            print(
                                                controller.todoList[index].id);
                                            Get.back();
                                          },
                                          icon: Icon(Icons.done)),
                                    ],
                                    title: Text('Task'),
                                    content: ListView(
                                      children: [
                                        TextFieldCom(
                                          controller: title,
                                          maxLine: 1,
                                          title: "Title",
                                        ),
                                        TextFieldCom(
                                          controller: desc,
                                          maxLine: 5,
                                          title: "Title",
                                        ),
                                      ],
                                    ));
                              });
                        },

                        ///List of tasks
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(2),
                            tileColor: Colors.white,
                            title: Text(controller.todoList[index].title,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ),
                    );
                  },
                )),
        ));
  }
}
