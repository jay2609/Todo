import 'package:ekstep_assignment/model/todoModel.dart';

abstract class ToDoAbs {
  //google sign in method abstraction declaration
  addNewTask(todoModel model);
  Stream<List<todoModel>> getallTodoList();
}
