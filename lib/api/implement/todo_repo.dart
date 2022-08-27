import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekstep_assignment/api/abstract/todo_abs.dart';
import 'package:ekstep_assignment/constant/firebase.dart';
import 'package:ekstep_assignment/model/todoModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToDoRepo extends ToDoAbs {
  addNewTask(todoModel model) {
    FirebaseFirestore.instance
        .collection(Collections.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection(Collections.toDoCollection)
        .doc(model.id.toString())
        .set(model.toJson());
  }

  EditTask(title, desc, String docID) {
    try {
      FirebaseFirestore.instance
          .collection(Collections.usersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection(Collections.toDoCollection)
          .doc(docID)
          .update({"title": title, "description": desc}).then((value) {
        Get.snackbar("Edited", "Task Edited Successfully",
            colorText: Colors.green);
      });
    } catch (e) {
      Get.snackbar("Failed To edit", e.toString(), colorText: Colors.red);
    }
  }

  DeleteTask(String docID) {
    try {
      FirebaseFirestore.instance
          .collection(Collections.usersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection(Collections.toDoCollection)
          .doc(docID)
          .delete()
          .then((value) {
        Get.snackbar("Deleted", "Task Deleted Successfully",
            colorText: Colors.green);
      });
    } catch (e) {
      Get.snackbar("Failed To Delete", e.toString(), colorText: Colors.red);
    }
  }

  updateOneField(field, val, String docID) {
    try {
      FirebaseFirestore.instance
          .collection(Collections.usersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection(Collections.toDoCollection)
          .doc(docID)
          .update({field: val}).then((value) {
        Get.snackbar("Marked to Completed", "Task Completed Successfully",
            colorText: Colors.green);
      });
    } catch (e) {
      Get.snackbar("Failed To Mark", e.toString(), colorText: Colors.red);
    }
  }

  Stream<List<todoModel>> getallTodoList() {
    try {
      return FirebaseFirestore.instance
          .collection(Collections.usersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection(Collections.toDoCollection)
          .orderBy("createdDate", descending: true)
          .where("completed", isEqualTo: false)
          .snapshots()
          .map((event) => event.docs.map((e) {
                return todoModel.fromMap(e.data(), e.id);
              }).toList());
    } catch (e) {
      return Stream.value(<todoModel>[]);
    }
  }
}
