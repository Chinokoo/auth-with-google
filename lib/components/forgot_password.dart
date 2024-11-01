import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final String textInput;
  final VoidCallback onTap;
  const ForgotPassword(
      {super.key, required this.textInput, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            textInput,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
