import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFieldCom extends StatelessWidget {
  String title;
  int maxLine;
  final TextEditingController controller;

  TextFieldCom(
      {required this.maxLine,
      required this.title,
      required this.controller,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLines: maxLine, //or null

        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: title,
        ),
      ),
    );
  }
}
