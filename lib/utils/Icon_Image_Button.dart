import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class IconImageButton extends StatelessWidget {
  String iconText;

  VoidCallback onTap;
  Color bgColor;

  IconImageButton(
      {required this.iconText,
      required this.onTap,
      this.bgColor = Colors.white,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        color: bgColor,
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(iconText),
          ],
        ),
      ),
    );
  }
}
