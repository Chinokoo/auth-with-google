import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  bool obscureText;
  String hintText;
  IconData iconData;
  TextEditingController textEditingController;

  InputField(
      {super.key,
      required this.obscureText,
      required this.hintText,
      required this.textEditingController,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: textEditingController,
        obscureText: obscureText,
        decoration: InputDecoration(
            filled: true,
            prefix: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10, top: 0),
              child: Icon(
                iconData,
                color: Colors.grey[400],
                size: 19,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 18),
            fillColor: const Color(0xFFedf0f8),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(30),
            )),
      ),
    );
  }
}
